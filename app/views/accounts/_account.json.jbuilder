json.extract! account, :id, :user_id, :name, :uin, :uin_type, :type, :status, :created_at, :updated_at
json.url account_url(account, format: :json)
