# == Schema Information
#
# Table name: mother_boards
#
#  id                         :uuid             not null, primary key
#  config                     :jsonb            not null
#  durability_loss            :float            not null
#  mem_max_capacity_megabytes :integer          not null
#  product_model_name         :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  product_model_id           :string           not null
#
FactoryBot.define do
  factory :mother_board do
    # config do
    #   { sockets: [:usb_socket, :sata_socket] }
    # end
    config do
      { sockets: [] }
    end
    mem_max_capacity_megabytes { 1000 }
    durability_loss { 0.001 }
    product_model_id { SecureRandom.uuid }
    product_model_name { "mother board #{product_model_id}" }
  end
end
