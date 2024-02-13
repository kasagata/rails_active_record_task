class Customer < ApplicationRecord
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :orders, dependent: :destroy

  def self.foods_price_sum
    Food.sum("price")
  end
end
