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
#
FactoryBot.define do
  factory :hard_drive do
    durability_loss { 0.001 }
    speed_megabytes { 5 }
    capacity_megabytes { 9000 }
    product_model_id { SecureRandom.alphanumeric }
    product_model_name { "harddrive #{product_model_id}" }
    sata

    trait :sata do
      socket_type { "SataSocket" }
    end

    trait :usb do
      socket_type { "UsbSocket" }
    end
  end
end
