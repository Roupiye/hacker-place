# == Schema Information
#
# Table name: mother_board_hardwares
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  machine_id      :uuid             not null
#  mother_board_id :uuid             not null
#
# Indexes
#
#  index_mother_board_hardwares_on_machine_id       (machine_id)
#  index_mother_board_hardwares_on_mother_board_id  (mother_board_id)
#
# Foreign Keys
#
#  fk_rails_...  (machine_id => machines.id)
#  fk_rails_...  (mother_board_id => mother_boards.id)
#
require "test_helper"

class MotherBoardHardwareTest < ActiveSupport::TestCase
  test "after_create should set the sockets_harwares using mother_board" do
    mom = create(:mother_board)
    mom_awe = create(:mother_board_hardware, mother_board: mom, machine: build(:machine))
    assert_empty mom_awe.sockets

    create(:sata_socket, mother_board: mom)
    mom.reload
    mom_awe = create(:mother_board_hardware, mother_board: mom, machine: build(:machine))
    refute_empty mom_awe.sockets
    assert_equal SataSocketHardware, mom_awe.sockets.last.class
  end

  # test "sockets" do
  # end
end
