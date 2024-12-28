# == Schema Information
#
# Table name: sata_socket_hardwares
#
#  id                       :uuid             not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  mother_board_hardware_id :uuid             not null
#  sata_socket_id           :uuid             not null
#
# Indexes
#
#  index_sata_socket_hardwares_on_mother_board_hardware_id  (mother_board_hardware_id)
#  index_sata_socket_hardwares_on_sata_socket_id            (sata_socket_id)
#
# Foreign Keys
#
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#  fk_rails_...  (sata_socket_id => sata_sockets.id)
#
require "test_helper"

class SataSocketHardwareTest < ActiveSupport::TestCase
  test "validate_socket_type" do
    socket = build(:sata_socket_hardware)
    hard_drive_awe = create(:hard_drive_hardware, :usb)

    socket.plug(hard_drive_awe)
    socket.valid?
    refute_empty socket.errors[:plugged_hardware]

    hard_drive_awe = create(:hard_drive_hardware, :sata)
    socket.plug(hard_drive_awe)
    socket.valid?
    assert_empty socket.errors[:plugged_hardware]
  end
end
