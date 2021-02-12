class User < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :email, uniqueness: true

  def self.allowed_attributes_update
    %i[email name]
  end
end
