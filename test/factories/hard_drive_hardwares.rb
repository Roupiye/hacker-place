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
FactoryBot.define do
  factory :hard_drive_hardware do
    name { SecureRandom.alphanumeric }
    bootable { false }
    sata

    trait :sata do
      buyable { build(:hard_drive, :sata) }
    end

    trait :usb do
      buyable { build(:hard_drive, :usb) }
    end
  end
end
