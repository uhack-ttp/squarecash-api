class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
