class Config::MotherBoardForm < ApplicationView
  include Phlex::Rails::Helpers::FormFor

  def initialize(mother_board = MotherBoard.new)
    @mother_board = mother_board
  end

  def view_template
    if @mother_board.persisted?
      button(
        data_reflex: "click->ConfigReflex#cancel_edit_mother_board",
      ) {"cancel editing"}
    end

    form_for(@mother_board) { |f|
      label {"durability_loss: "};br;f.text_field :durability_loss;br
      label {"mem_max_capacity_megabytes: "};br;f.number_field :mem_max_capacity_megabytes;br
      label {"product_model_name: "};br;f.text_field :product_model_name;br
      label {"product_model_id: "};br;f.text_field :product_model_id;br
      label {"config: "};br;f.text_field :config;br
      f.submit
    }
  end
end
