class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :account, foreign_key: true
      t.string :c_no         ,null: true, comment: "卡号"
      t.string :c_pw         ,null: true, comment: "密码"
      t.integer :p_limit_d_cents    , null: true, limit:8, default: Wallet::BANK_WALLET_LIMIT , comment: "支付限制 每日限额"
      # t.string :limit_circle ,null: true, default: 24, comment: "限制周期"

      t.integer :amount_cents       , null: true, limit:8, default: 0 , comment: "周期内支付的数量"
      t.string :type         ,null: true, comment: "类型 BankWallet"
      t.integer :state        ,null: false, default: 1, comment:"钱包状态 0 1 启用"

      t.datetime :circle_updated_at, null:true, comment:'周期更新时间'
      t.timestamps
    end
  end
end
