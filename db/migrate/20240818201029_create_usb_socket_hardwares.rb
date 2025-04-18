class CreateUsbSocketHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :usb_socket_hardwares, id: :uuid do |t|
      t.references :mother_board_hardware, null: false, foreign_key: true, type: :uuid
      t.references :usb_socket, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

