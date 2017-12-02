class Customer < User
  has_many :transactions
  has_one  :account, as: :owner

  def active_transaction
    transactions.where(aasm_state: 'active').last
  end

  def balance
    account.balance
  end
end
