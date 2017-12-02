class Store < ApplicationRecord
  has_many :transactions
  has_many :products
  belongs_to :store_admin

  def total_sales
    transactions.to_a.sum(&:total_price)
  end

  def total_quantity_sold
    products.map{|p| p.items.to_a.sum(&:quantity)}.sum
  end
end
