class WrongSocketPlugError < StandardError
  def initialize = super("plugging hardware in the wrong socket")
end

class EmptySocketUnplugError < StandardError
  def initialize = super("unplug empty socket")
end

class SocketTypeValidator < ActiveModel::Validator
  def validate(record)
    if record.plugged_hardware
      if record.plugged_hardware.buyable.socket_type != record.class.name.gsub("Hardware", "")
        record.errors.add :plugged_hardware, "of wrong socket type"
      end
    end
  end
end

module SocketHardwareConcern
  extend ActiveSupport::Concern

  included do
    validates_with SocketTypeValidator

    def plug(hardware)
      self.plugged_hardware = hardware
    end

    def unplug
      self.plugged_hardware = nil
    end

    def unplug!
      self.plugged_hardware = nil
      save!
    end

    def plug!(hardware)
      self.plugged_hardware = hardware
      save!
    end
  end

  class_methods do
    # has_one :plugged_hardware, class_name: :HardDriveHardware, as: :connected_socket
    def has_plugabled_hardware(classes_list)
      classes_list.each do |klass|
        has_one :plugged_hardware, class_name: klass.name.to_sym, as: :connected_socket
      end
    end
  end
end
