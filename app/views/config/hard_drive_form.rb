class Config::HardDriveForm < ApplicationView
  include Phlex::Rails::Helpers::FormFor
  attr_accessor :hard_drive

  def initialize(hard_drive = HardDrive.new)
    @hard_drive = hard_drive
  end

  def view_template
    if hard_drive.persisted?
      button(
        data_reflex: "click->ConfigReflex#cancel_edit_mother_board",
      ) {"cancel editing"}
    end

    form_for(hard_drive) { |f|
      label {"socket_type: "};br;f.text_field :socket_type;br
      f.submit
    }
  end
end
