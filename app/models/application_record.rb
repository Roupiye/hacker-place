class ApplicationRecord < ActiveRecord::Base
  self.implicit_order_column = "created_at"

  include CableReady::Updatable

  include CableReady::Broadcaster
  primary_abstract_class
end
