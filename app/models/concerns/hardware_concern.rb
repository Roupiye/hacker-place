module HardwareConcern
  extend ActiveSupport::Concern

  included do
    belongs_to(
      :buyable,
      # class_name: :HardDrive,
      class_name: name.gsub("Hardware", "").to_sym,
      #foreign_key: :hard_drive_id
      foreign_key: name.underscore.gsub("_hardware", "_id").to_sym
    )
  end

  class_methods do
  end
end
