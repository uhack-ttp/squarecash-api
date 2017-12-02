class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :add_total_price
  before_save :calculate_product_quantity
  before_destroy :return_stocks_to_product

  private

  def add_total_price
    self.price = product.price * self.quantity
  end

  def calculate_product_quantity
    return false unless quantity_changed?
    qty = (quantity - (quantity_was || 0))
    product.decrement(:quantity, qty).save!
  end

  def return_stocks_to_product
    product.increment(:quantity, quantity).save!
  end
end
