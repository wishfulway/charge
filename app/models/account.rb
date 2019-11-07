class Account < ApplicationRecord
  belongs_to :user
  belongs_to :account_type
  validates :user_id, presence: true



end
