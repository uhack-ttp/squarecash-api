class Product < ApplicationRecord
  has_many :items
  belongs_to :store
end
