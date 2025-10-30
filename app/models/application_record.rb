class ApplicationRecord < ActiveRecord::Base
  self.implicit_order_column = "created_at"
  include CableReady::Updatable
  include CableReady::Broadcaster
  primary_abstract_class

  def clean_attrs
    attributes
      .except!("id", "created_at", "updated_at")
      .delete_if { |key, _| key.to_s.end_with?('_id') }
  end
end
