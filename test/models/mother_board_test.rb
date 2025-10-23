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
require "test_helper"

class MotherBoardTest < ActiveSupport::TestCase
  test "should include buyable concern" do
    assert MotherBoard.included_modules.include?(BuyableConcern)
  end

  test "validations" do
    mom = create(:mother_board)

    mom.valid?
    assert_empty mom.errors
  end

  test "sockets" do
    mom = create(:mother_board)

    assert_empty mom.sockets
    mom.config["sockets"] << :sata_socket
    mom.save!
    refute_empty mom.sockets
    assert_equal SataSocket, mom.sockets.last.class
  end
end
