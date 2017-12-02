class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :customer
      t.belongs_to :store
      t.money      :total_price, default: 0
      t.string     :state
      t.string     :type

      t.timestamps
    end
  end
end
