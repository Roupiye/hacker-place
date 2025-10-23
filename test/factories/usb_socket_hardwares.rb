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
FactoryBot.define do
  factory :usb_socket_hardware do
    
  end
end
