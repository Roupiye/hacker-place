class ApplicationSocket
  def self.socket_classes_list
    result = []

    # [UsbSocket, SataSocket]
    Dir.entries("#{Rails.root}/app/models/hardwares/sockets").each do |file|
      next if file == "application_socket.rb"

      if file[-9..] == "socket.rb"
        result << file.split(".").first.camelize.constantize
      end
    end
    result
  end
end
