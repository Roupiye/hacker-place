class CreateHardDriveHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :hard_drive_hardwares, id: :uuid do |t|
      t.references :hard_drive, null: false, foreign_key: true, type: :uuid
      t.references :connected_socket, polymorphic: true, null: true, type: :uuid

      t.timestamps
    end
  end
end
