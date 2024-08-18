# == Schema Information
#
# Table name: usb_socket_hardwares
#
#  id                       :uuid             not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  mother_board_hardware_id :uuid             not null
#  usb_socket_id            :uuid             not null
#
# Indexes
#
#  index_usb_socket_hardwares_on_mother_board_hardware_id  (mother_board_hardware_id)
#  index_usb_socket_hardwares_on_usb_socket_id             (usb_socket_id)
#
# Foreign Keys
#
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#  fk_rails_...  (usb_socket_id => usb_sockets.id)
#
require "test_helper"

class UsbSocketHardwareTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
