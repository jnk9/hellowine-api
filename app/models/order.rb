class Order < ApplicationRecord
  enum payment_status: %i[pending_payment no_paid paid ]
  enum order_status: %i[in_preparation in_delivery delivered received]

  scope :by_delivery_date_day, -> (date) { where('extract(day from delivery_date) = ?', date.day) }
  scope :by_delivery_date_month, -> (date) { where('extract(month from delivery_date) = ?', date.month) }
  scope :by_delivery_date_year, -> (date) { where('extract(year from delivery_date) = ?', date.year) }

  belongs_to :user

  validates :user, presence: true

  def self.allowed_attributes_create
    %i[amount user_id]
  end

  def self.allowed_attributes_update
    %i[payment_status order_status]
  end
end