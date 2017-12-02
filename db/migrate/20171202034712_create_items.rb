class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.belongs_to :cart
      t.belongs_to :product
      t.money      :price
      t.integer    :quantity

      t.timestamps
    end
  end
end
