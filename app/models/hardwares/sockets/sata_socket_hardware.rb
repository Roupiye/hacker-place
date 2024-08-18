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
class SataSocketHardware < ApplicationRecord
  belongs_to :mother_board_hardware
  belongs_to :socket, class_name: :SataSocket, foreign_key: :sata_socket_id
  has_one :plugged_hardware, class_name: :HardDriveHardware, as: :connected_socket

  def plug(hardware)
    hardware.update!(connected_socket: self)
  end
end
