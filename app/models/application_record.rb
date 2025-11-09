class ApplicationRecord < ActiveRecord::Base
  self.implicit_order_column = "created_at"
  include CableReady::Updatable
  include CableReady::Broadcaster
  primary_abstract_class

  def clean_attrs(filter_exceptions: [])
    filters = attributes.keys.select{it.to_s.end_with?('_id')}
    filters += ["id", "created_at", "updated_at"]
    filters -= filter_exceptions

    attributes.except!(*filters)
  end
end
