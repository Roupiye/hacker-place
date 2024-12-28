class DesktopEnvironmentComponent < ApplicationComponent
  def initialize machine:
    @machine = machine
  end

  def view_template
    button(
      class: "btn absolute hidden",
      onclick: safe("debug_console.showModal()"),
      data: {
        controller: "click",
        action: "keydown.alt+c@window->click#click"
      }
    ) { "open modal" }
    debug_console
    div(
      id: "de",
      class: "flex flex-col min-h-screen",
      style: "background-image: url(\"#{image_url("wallpaper")}\"); background-position: center; background-size: cover;",
      data: {
        controller: "de",
        de_machine_id_value: @machine.id,
        de_active_app_value: ""
      }
    ) {
      desktop
      taskbar
    }
  end

  def desktop
    div(
      id: "desktop-open-apps",
      class: "flex-1 flex",
      data: {
        de_target: "desktop"
      }
    ) {
    }
  end

  def debug_console
    dialog(id: "debug_console", class: "modal") do
      div(class: "modal-box") do
        h3(class: "text-lg font-bold") { "Hello!" }
        p(class: "py-4") { "Press ESC key or click the button below to close" }
        div(class: "modal-action") do
          form(method: "dialog") do
            whitespace
            comment { "if there is a button in form, it will close the modal" }
            whitespace
            button(class: "btn") { "Close" }
          end
        end
      end
    end

  end

  def taskbar
    div(
      class: "bg-black/80 flex z-10",
      data: {
        de_target: "taskbar",
        controller: "taskbar",
        taskbar_de_outlet: "#de"
      }
    ) {
      div(class: "dropdown dropdown-top") {
        button(id: "de-task-menu", class: "font-semibold px-2 py-1") { "Applications" }
        ul(
          tabindex: "0",
          class:
          "dropdown-content z-[9999] menu p-0 shadow bg-black w-52"
        ) {
          Desktop::AppFactory::APPS.each { |app|
            li {
              button(
                data: {
                  action: "click->taskbar#openApp",
                  app: app
                },
                class: "rounded-none"
              ) { app }
            }
          }
        }
      }
      div(id: "taskbar-open-apps", class: "flex") {}
    }
  end
end
