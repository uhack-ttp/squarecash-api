class Cart < Transaction
  has_many :items, dependent: :destroy

  before_validation :set_transaction_code, on: :create

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
