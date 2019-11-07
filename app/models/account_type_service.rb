class AccountTypeService < ApplicationRecord
  belongs_to :account_type
  belongs_to :service
end
