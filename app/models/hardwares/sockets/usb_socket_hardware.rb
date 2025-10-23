# == Schema Information
#
# Table name: usb_socket_hardwares
#
#  id                       :uuid             not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  mother_board_hardware_id :uuid             not null
#
# Indexes
#
#  index_usb_socket_hardwares_on_mother_board_hardware_id  (mother_board_hardware_id)
#
# Foreign Keys
#
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#
class UsbSocketHardware < ApplicationRecord
  include SocketHardwareConcern
  has_plugabled_hardware [HardDriveHardware]

  belongs_to :mother_board_hardware
end
