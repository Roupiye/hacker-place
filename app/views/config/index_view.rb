class Config::IndexView < ApplicationView
  include Phlex::Rails::Helpers::FormFor

  def initialize()
  end

  def view_template
    div(class: "flex border-b border-white") {
      div(id: "config_form_1") {
        render Config::MotherBoardForm.new
      }
      div(class: "w-full flex") {
        MotherBoard.all.each { |mom|
          div(class: "px-2") {
            mom.clean_attrs.each { |k, v|
              tuple_display(k,v)
            }
            button(
              data_reflex: "click->ConfigReflex#spawn_mom_hardware",
              data_mother_board_id: mom.id
            ) { "spawn hardware" };br
            button(
              data_reflex: "click->ConfigReflex#edit_mother_board",
              data_mother_board_id: mom.id
            ) { "edit" }
          }
        }
      }
    }
    div(class: "flex border-b border-white") {
      div(class: "w-full flex") {
        MotherBoardHardware.all.each { |mom_hwe|
          div(class: "px-2") {
            mom_hwe.mother_board.clean_attrs.each { |k, v|
              tuple_display(k,v)
            }
          }
        }
      }
    }

    div(class: "flex border-b border-white") {
      div(id: "config_form_2") {
        render Config::HardDriveForm.new
      }
      div(class: "w-full flex") {
        HardDrive.all.each { |hard_drive|
          div(class: "px-2") {
            hard_drive.clean_attrs.each { |k, v|
              tuple_display(k,v)
            }
            button(
              data_reflex: "click->ConfigReflex#spawn_hard_drive_hardware",
              data_hard_drive_id: hard_drive.id
            ) { "spawn hardware" };br
            button(
              data_reflex: "click->ConfigReflex#edit_hard_drive",
              data_hard_drive_id: hard_drive.id
            ) { "edit" }
          }
        }
      }
    }
    div(class: "flex border-b border-white") {
      div(class: "w-full flex") {
        HardDriveHardware.all.each { |hard_drive_hwe|
          div(class: "px-2") {
            hard_drive_hwe.hard_drive.clean_attrs.each { |k, v|
              tuple_display(k,v)
            }
          }
        }
      }
    }
  end

  private

  def tuple_display(k,v)
    plain("#{k}: ");plain(v.to_s);br
  end
end
