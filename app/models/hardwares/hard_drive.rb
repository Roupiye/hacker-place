# == Schema Information
#
# Table name: hard_drives
#
#  id                 :uuid             not null, primary key
#  capacity_megabytes :integer          not null
#  durability_loss    :float            not null
#  product_model_name :string           not null
#  socket_type        :string           not null
#  speed_megabytes    :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_model_id   :string           not null
#  socket_id          :uuid             not null
#
# Indexes
#
#  index_hard_drives_on_socket  (socket_type,socket_id)
#
class HardDrive < ApplicationRecord
  include BuyableConcern

  has_many :hard_drive_hardwares

  validates :speed_megabytes, presence: true
  validates :capacity_megabytes, presence: true

  belongs_to :socket, polymorphic: true
end
