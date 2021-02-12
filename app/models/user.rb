class User < ApplicationRecord
  has_many :orders

  validates :email, uniqueness: true

  def self.allowed_attributes_update
    %i[email name]
  end
end
