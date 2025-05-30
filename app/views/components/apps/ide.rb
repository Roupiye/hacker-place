class Apps::Ide < ApplicationComponent
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::TextField

  attr_reader :app, :app_id

  def initialize(machine_id:, app_id: nil, args: [])
    @machine_id = machine_id
    @app_id = app_id || "app-#{SecureRandom.hex}"
    @app = :ide
  end

  def view_template
    div(
      data: {
        controller: "ide",
        ide_machine_id_value: @machine_id,
        ide_app_id_value: @app_id,
        ide_de_outlet: "#de"
      },
      class: "h-full flex flex-col"
    ) do
      code_editor
      ide_bottom_nav
    end
  end

  def code_editor
    div(class: "grow flex", data_controller: "responsive-box") {
      div(
        class: "absolute ide-editor",
        data_controller: "monaco",
        data_responsive_box_target: "el",
        data_ide_target: "code"
      ) {}
      div(
        class: "grow",
        data_responsive_box_target: "shadowEl"
      ) {}
    }
  end

  def ide_bottom_nav
    div(
      class: "flex mt-2 items-center"
    ) {
      label(for: "code_params") { "params: " }
      text_field(
        :code, :params,
        class: "input input-bordered input-sm w-full max-w-xs ml-2",
        data: {ide_target: "codeparams"}
      )

      button(
        class: "ml-auto btn btn-sm btn-primary",
        data_action: " click->ide#runScript"
      ) { "run" }

      button(
        class: "ml-auto btn btn-sm btn-primary",
        data_action: " click->ide#saveScript"
      ) { "save" }
    }
  end
end
