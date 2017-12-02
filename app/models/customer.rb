class Customer < User
  has_many :transactions

  def active_transaction
    transactions.where(aasm_state: 'active').last
  end
end
