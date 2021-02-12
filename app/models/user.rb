class User < ApplicationRecord
  has_many :orders

  validates :email, uniqueness: true
end
