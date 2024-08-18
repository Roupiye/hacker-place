module HardwarePlugableConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :connected_socket, polymorphic: true, optional: true
  end

  class_methods do
  end
end
