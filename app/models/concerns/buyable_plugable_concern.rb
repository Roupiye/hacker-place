module BuyablePlugableConcern
  extend ActiveSupport::Concern

  included do
    validates(
      :socket_type,
      presence: true
    )
  end

  class_methods do
  end
end
