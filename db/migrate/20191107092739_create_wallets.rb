class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :account,  null: false, foreign_key: true
      t.string :c_no         ,null: false, comment: "卡号"
      t.string :c_pw         ,null: true, comment: "密码"
      # limit 8 bigint 20
      t.integer :p_limit_d_cents    , null: true, limit:8, default: Wallet::BANK_WALLET_LIMIT , comment: "支付限制 每日限额"
      # t.string :limit_circle ,null: true, default: 24, comment: "限制周期"

      t.integer :amount_cents       , null: true, limit:8, default: 0 , comment: "周期内已支付的数额"
      # t.integer :remained_cents       , null: true, limit:8, default: 0 , comment: "周期内剩余可支付的数量"
      t.string :type         ,null: false, comment: "类型 BankWallet"
      t.integer :state        ,null: true, default: 1, comment:"钱包状态 0 1 启用"

      t.integer :amount_qb       , null: true, limit:8, default: 0 , comment: "登记qb数量"
      t.integer :remained_qb       , null: true, limit:8, default: 0 , comment: "剩余qb数量"

      t.integer :priority, null: false, default: Wallet::DEFAULT_WALLET_PRIORITY, comment: "优先级"

      t.timestamp :amount_updated_at , null:true, default: Time.now, comment:'周期更新时间'

      t.timestamps
    end
    add_index :wallets, [:account_id, :c_no, :type], unique: true
  end
end
