require "json"

class RunProcessJob < ApplicationJob
  def perform(app_id:, code:, params:, machine_id:)
    terminal_broadcaster = TerminalBroadcast.new(app_id, app_id)
    terminal_broadcaster.clear_terminal

    lgo = Lgo.new(
      code,
      machine: Machine.find(machine_id),
      params: params,
      pid: app_id,
      intrinsics_args: {broadcaster: terminal_broadcaster}
    )

    lgo.intrinsics.initialize_server
    LgoProcess.find_by(pid: app_id).update!(intrinsics_uri: lgo.intrinsics.uri)
    lgo.run
  end
end
