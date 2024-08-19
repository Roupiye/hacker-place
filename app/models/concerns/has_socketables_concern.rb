module HasSocketablesConcern
  extend ActiveSupport::Concern

  # [:sata_socket, :usb_socket]
  @@sockets ||= ::ApplicationSocket.socket_classes_list.map do |klass|
    klass.name.underscore.to_sym
  end
  @@sockets.freeze

  included do
    # if hardware
    #   has_many :sata_socket_hardwares
    #   has_many :usb_socket_harwares
    # else
    #   has_many :sata_sockets
    #   has_many :usb_sockets
    if hardware?
      @@sockets.each do |socket|
        has_many "#{socket.to_s}_hardwares".to_sym
      end
    else
      @@sockets.each do |socket|
        has_many socket.to_s.pluralize.to_sym
      end
    end

    # if hardware
    #   [sata_socket_harwares, usb_sockets_hardwares].flatten
    # else
    #   [sata_sockets, usb_sockets].flatten
    def sockets
      @@sockets.map do |socket|
        send("#{socket.to_s}#{self.class.hardware? ? "_hardwares" : ""}".pluralize)
      end.flatten
    end
  end

  class_methods do
    def sockets = @@sockets
    def hardware? = name.to_s.include? "Hardware"
  end
end
