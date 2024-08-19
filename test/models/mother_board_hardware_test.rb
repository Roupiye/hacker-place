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

    ApplicationSocket.socket_classes_list do |klass|
      mom = create(:mother_board)

      # create(sata_socket, mother_board: mom)
      create(klass.name.underscore, mother_board: mom)
      mom.reload
      mom_awe = create(:mother_board_hardware, mother_board: mom, machine: build(:machine))

      assert_equal 1, mom_awe.sockets.size
      # assert_equal SataSocketHardware.constantize, mom_awe.sockets.last.class
      assert_equal (klass.name + "Hardware").constantize, mom_awe.sockets.last.class
    end
  end

  test "plug something to socket" do
    mom = create(
      :mother_board,
      sata_sockets: [
        build(:sata_socket)
      ]
    )

    mom_awe = create(:mother_board_hardware, mother_board: mom, machine: build(:machine))
    hard_drive_awe = create(:hard_drive_hardware, :sata)

    mom_awe.sockets.last.plug(hard_drive_awe)
    assert_equal mom_awe.sockets.last.plugged_hardware, hard_drive_awe
  end
end
