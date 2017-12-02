class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string   :name,       null: false
      t.string   :token,      null: false
      t.datetime :expires_at, null: false
      t.text     :domains,    null: false, default: ''

      t.timestamps null: false
    end
  end
end
