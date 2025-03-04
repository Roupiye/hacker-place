# == Schema Information
#
# Table name: partitions
#
#  id                     :uuid             not null, primary key
#  bootable               :boolean          not null
#  encryption_password    :string
#  size_megabytes         :integer          not null
#  start_position         :integer          not null
#  type                   :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hard_drive_hardware_id :uuid             not null
#
# Indexes
#
#  index_partitions_on_hard_drive_hardware_id  (hard_drive_hardware_id)
#
# Foreign Keys
#
#  fk_rails_...  (hard_drive_hardware_id => hard_drive_hardwares.id)
#
class Partition < ApplicationRecord
  belongs_to :hard_drive_hardware

  enum :type, [:ext4, :ntfs, :fat]

  validates :bootable, presence: true
  validates :type, presence: true
  validates :start_position, presence: true
  validates :size_megabytes, presence: true
end
