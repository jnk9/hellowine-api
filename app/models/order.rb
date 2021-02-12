class Order < ApplicationRecord
  enum payment_status: %i[pending_payment paid no_paid ]
  enum order_status: %i[in_preparation in_delivery delivered received]

  belongs_to :user
end