class Transaction < ApplicationRecord
  include AASM

  belongs_to :customer
  belongs_to :store, required: false

  before_save :update_user_and_store_admin_accounts
  validate :customer_must_have_enough_balance

  aasm do
    state :active, initial: true
    state :done

    event :finish do
      transitions from: :active, to: :done
    end
  end

  protected

  def customer_must_have_enough_balance
    return true if customer.balance >= total_price
    errors.add(:customer, message: "customer doesn't have enough balance")
  end

  def update_user_and_store_admin_accounts
    return false if self.active?
    store_admin_account = store.store_admin.account
    customer_account = customer.account

    store_admin_account.increment(:balance, total_price).save!
    customer_account.decrement(:balance, total_price).save!
  end
end
