# == Schema Information
#
# Table name: usb_sockets
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  mother_board_id :uuid             not null
#
# Indexes
#
#  index_usb_sockets_on_mother_board_id  (mother_board_id)
#
# Foreign Keys
#
#  fk_rails_...  (mother_board_id => mother_boards.id)
#
class UsbSocket < ApplicationRecord
  belongs_to :mother_board
end
