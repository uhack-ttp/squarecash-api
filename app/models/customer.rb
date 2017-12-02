class Customer < User
  has_many :transactions
  has_one  :account, as: :owner

  def active_transaction
    transactions.where(aasm_state: 'active', type: 'Cart').last
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def balance
    account.balance
  end
end
