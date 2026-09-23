class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  attr_reader :terminal_broadcaster, :de_broadcaster

  def subscribed
    @machine_id = params["machineId"]
    @app_id = params["appId"]
    stream_for @app_id
  end

  def unsubscribed
    cable_intrinsics_server.kill
  rescue DRb::DRbConnError
  end

  def input(args)
    str = args["input"]

    terminal_broadcaster.disable_input(str)

    # todo this cable_intrinsics_server was set only once in the initializer but it could be called
    # before the server started and it caused problems
    cable_intrinsics_server.receive_input(str)
  end

  def run(args)
    args.transform_keys(&:underscore).symbolize_keys => {app_id:, code:, params:}

    @terminal_broadcaster = TerminalBroadcast.new(app_id, app_id)

    RunProcessJob.perform_later(
      app_id:,
      code:,
      params:,
      machine_id: @machine_id
    )
    DRb.start_service
  end

  private

  def cable_intrinsics_server
    @cable_intrinsics_server ||= DRbObject.new_with_uri(LgoProcess.find_by(pid: @app_id).intrinsics_uri)
  end
end
