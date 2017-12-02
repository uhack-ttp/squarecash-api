class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string     :name
      t.money      :price
      t.string     :type
      t.belongs_to :store

      t.timestamps
    end
  end
end
