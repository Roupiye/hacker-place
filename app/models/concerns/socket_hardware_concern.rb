class WrongSocketPlugError < StandardError
  def initialize = super("plugging hardware in the wrong socket")
end

module SocketHardwareConcern
  extend ActiveSupport::Concern

  included do
    def plug(hardware)
      if hardware.buyable.socket_type != self.class.name.gsub("Hardware", "")
        raise WrongSocketPlugError
      end

      hardware.update!(connected_socket: self)
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
