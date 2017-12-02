class Product < ApplicationRecord
  has_many :items
  belongs_to :store

  before_validation :add_product_code, on: :create

  private

  def add_product_code
    self.code = generate_product_code
  end

  def generate_product_code
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
