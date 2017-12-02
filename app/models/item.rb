class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :add_total_price

  private

  def add_total_price
    self.price = product.price * self.quantity
  end
end
