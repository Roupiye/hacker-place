# == Schema Information
#
# Table name: hard_drive_hardwares
#
#  id                    :uuid             not null, primary key
#  bootable              :boolean          not null
#  connected_socket_type :string
#  name                  :string           not null
#  path_mount_table      :jsonb
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  connected_socket_id   :uuid
#  hard_drive_id         :uuid             not null
#
# Indexes
#
#  index_hard_drive_hardwares_on_connected_socket  (connected_socket_type,connected_socket_id)
#  index_hard_drive_hardwares_on_hard_drive_id     (hard_drive_id)
#
# Foreign Keys
#
#  fk_rails_...  (hard_drive_id => hard_drives.id)
#
require "test_helper"

class HardDriveHardwareTest < ActiveSupport::TestCase
  test "plugging the drive into a different socket should ilegal" do
    mom = create(
      :mother_board,
      sata_sockets: [
        build(:sata_socket)
      ]
    )

    mom_awe = create(:mother_board_hardware, mother_board: mom, machine: build(:machine))
    hard_drive_awe = create(:hard_drive_hardware, :usb)

    assert_raise WrongSocketPlugError do
      mom_awe.sockets.last.plug(hard_drive_awe)
    end
  end
end
