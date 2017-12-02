class Store < ApplicationRecord
  has_many :transactions
  has_many :products
  belongs_to :store_admin
end
