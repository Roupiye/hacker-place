class Lgo
  attr_reader :write_io, :read_io, :pid
  attr_reader :intrinsics
  attr_reader :verbose
  attr_reader :machine

  attr_reader :code, :params, :script_path
  attr_accessor :last_line, :last_cmd, :last_cmd_result

  @@intrinsics = {
    terminal: Lgo::TerminalIntrinsics,
    cable: Lgo::CableIntrinsics,
    unit_test: Lgo::UnitTestIntrinsics
  }

  def initialize(code, machine:, params: "", intrinsics: :cable, intrinsics_args: {}, verbose: true)
    @verbose = Rails.env.test? ? false : verbose
    @code = code
    @params = params
    @machine = machine
    @calls_count = 0

    @v_process = VProcess.new.tap do |p|
      p.machine = @machine
      p.command = "lgoscript"
      p.name = "lgoscript"
      p.state = :waiting
      p.lgo_process = LgoProcess.new(
        pid: nil,
        state: :waiting,
        code: @code
      )
    end
    @v_process.save

    intrinsics_args[:lgo] = self
    @intrinsics = @@intrinsics[intrinsics].new(**intrinsics_args)
  end

  def verbose? = verbose

  def step_eval
    @exection_fiber.resume(self)
  end

  def send_result(return_value)
    @write_io.printf("->#{Lgo::ArgParser.dump(return_value)}\n")
  end

  ## steps flag is unstable dont use it
  def run(steps: false)
    if @v_process.state == "waiting"
      initiate_lua_script(code)
      puts("lgo running on pid #{@pid}") if verbose?

      @thr = mem_monitoring_thread

      setup
    end

    if steps
      step = step_eval
      if step.nil? == false
        send_result last_cmd.run
        @calls_count += 1
      end
    else
      while step_eval.nil? == false
        send_result last_cmd.run
      end
    end

    if steps == false || steps && step.nil? == true
      @thr.exit
      cleanup
    end
  end

  def kill
    puts "killing lgo", @pid
    `kill #{@pid}`
    # kill doest need to call clean up since
    # when the sub process is killed the fiber will be
    # unblocked and the clean up on the main flow is called
  end

  private

  def setup
    @v_process.update!(state: :running, started_at: Time.now)
    @v_process.lgo_process.update!(state: :running, started_at: Time.now)
  end

  def cleanup
    @v_process.update!(state: "dead", ended_at: Time.now)
    @v_process.lgo_process.update!(state: "dead", ended_at: Time.now)

    puts "killing cpulimit for #{@pid} #{@cpu_limit_pid}" if verbose?
    `kill #{@cpu_limit_pid} > /dev/null 2>&1`
  end

  def initiate_lua_script(code)
    file_name = SecureRandom.alphanumeric(15)
    @script_path = "/tmp/#{file_name}.lua"
    f = File.open(@script_path, "w")
    f.puts code
    f.close

    @read_io, @write_io, @pid = PTY.spawn("./app/lgo/lgo #{@script_path}")
    Process.detach(@pid)
    _, _, @cpu_limit_pid = PTY.spawn("cpulimit -p #{@pid} --limit 0.1")
    Process.detach(@cpu_limit_pid)

    @exection_fiber = Fiber.new do |lgo|
      loop do
        last_line = lgo.read_io.gets
        if last_line[0...2] == "->"
          puts last_line if verbose?
          lgo.last_line = last_line[2..]
        else
          puts "go: #{last_line}" if verbose?
          next
        end

        if Lgo::Cmd.is_cmd?(lgo.last_line)
          lgo.last_cmd = Lgo::Cmd.new(lgo)
          Fiber.yield lgo
        end
      rescue Errno::EIO
        break
      end
    end
  end

  def mem_monitoring_thread
    Thread.new do
      loop do
        ram_usage = `grep VmRSS /proc/#{@pid}/status | grep -o '[0-9]\\+' | awk '{print $1/1024}'`.to_f

        if ram_usage > 50
          kill
        end
        sleep 3
      end
    end
  end
end
