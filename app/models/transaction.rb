class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :store
end
