# frozen_string_literal: true

class ConfigReflex < ApplicationReflex
  def spawn_mom_hardware
    mom = MotherBoard.find(element.dataset.mother_board_id)
    mom.spawn_hardware(machine: Machine.new)
  end

  def edit_mother_board
    mom = MotherBoard.find(element.dataset.mother_board_id)
    morph "#config_form_1", render(Config::MotherBoardForm.new(mom))
  end

  def cancel_edit_mother_board
    morph "#config_form_1", render(Config::MotherBoardForm.new)
  end
end
