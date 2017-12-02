class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer    :owner_id
      t.string     :owner_type
      t.money      :balance, default: 0

      t.timestamps
    end
  end
end
