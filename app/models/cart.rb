class Cart < Transaction
  has_many :items, dependent: :destroy

  def total_price
    items.to_a.sum(&:price)
  end
end
