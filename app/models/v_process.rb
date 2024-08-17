# == Schema Information
#
# Table name: v_processes
#
#  id         :uuid             not null, primary key
#  command    :string           not null
#  cpu_usage  :integer          default(0), not null
#  ended_at   :date
#  name       :string
#  pid        :string           not null
#  ram_usage  :integer          default(0), not null
#  started_at :date
#  state      :integer          default("waiting"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  machine_id :uuid             not null
#
# Indexes
#
#  index_v_processes_on_machine_id  (machine_id)
#
# Foreign Keys
#
#  fk_rails_...  (machine_id => machines.id)
#
class VProcessValidator < ActiveModel::Validator
  def validate(record)
    if record.dead? && record.ended_at.nil?
      record.errors.add :ended_at, "Dead process should have ended_at set"
    end
  end
end

class VProcess < ApplicationRecord
  belongs_to :machine
  has_one :lgo_process

  enum :state, [:waiting, :running, :dead]

  attribute :started_at, default: -> { Time.now }
  attribute :pid, default: -> { rand(9999).to_s }

  validates_with VProcessValidator
  validates :pid, presence: true
  validates :command, presence: true
end
