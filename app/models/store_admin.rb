class StoreAdmin < User
  has_one :store
  has_one :account, as: :owner
end
