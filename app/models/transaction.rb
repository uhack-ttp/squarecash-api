class Transaction < ApplicationRecord
  include AASM

  belongs_to :customer
  belongs_to :store

  aasm do
    state :active, initial: true
    state :done

    event :finish do
      transitions from: :active, to: :done
    end
  end
end
