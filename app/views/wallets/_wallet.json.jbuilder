json.extract! wallet, :id, :account_id, :c_no, :c_pw, :pay_limit, :amount, :type, :state, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
