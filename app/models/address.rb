class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  has_many :orders, dependent: :destroy

  def self.orders_count
    orders.count
  end

end
