class Cart < Transaction
  has_many :items, dependent: :destroy

  before_validation :set_transaction_code, on: :create

  def self.find_or_create_active_cart(user, params)
    user.active_transaction || Cart.create!(params)
  end

  def total_price
    items.to_a.sum(&:price)
  end

  private

  def set_transaction_code
    self.code = generate_transaction_code
  end

  def generate_transaction_code
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
