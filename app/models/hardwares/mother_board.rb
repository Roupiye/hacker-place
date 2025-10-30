# == Schema Information
#
# Table name: mother_boards
#
#  id                         :uuid             not null, primary key
#  config                     :jsonb            not null
#  durability_loss            :float            not null
#  mem_max_capacity_megabytes :integer          not null
#  product_model_name         :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  product_model_id           :string           not null
#
class MotherBoard < ApplicationRecord
  include BuyableConcern
  # validations for price model name etc
  include HasSocketablesConcern
  # associtations for all sockets/socket_hardware classes

  has_many :mother_board_hardwares

  validates :config, presence: true
  validates :mem_max_capacity_megabytes, presence: true

  def spawn_hardware(machine:)
    MotherBoardHardware.create!(
      mother_board: self,
      machine: 
    )
  end
end
