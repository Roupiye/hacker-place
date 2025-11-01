class Config::HardDriveForm < ApplicationView
  include Phlex::Rails::Helpers::FormFor
  attr_accessor :hard_drive

  def initialize(hard_drive = HardDrive.new)
    @hard_drive = hard_drive
  end

  def view_template
    if hard_drive.persisted?
      button(
        data_reflex: "click->ConfigReflex#cancel_edit_hard_drive",
      ) {"cancel editing"}
    end

    form_for(hard_drive) { |f|
      label {"socket_type: "};br;f.text_field :socket_type;br
      label {"capacity_megabytes: "};br;f.text_field :capacity_megabytes;br
      label {"product_model_name: "};br;f.text_field :product_model_name;br
      label {"speed_megabytes: "};br;f.text_field :speed_megabytes;br
      label {"product_model_id: "};br;f.text_field :product_model_id;br
      label {"durability_loss: "};br;f.text_field :durability_loss;br

      f.submit
    }
  end
end
