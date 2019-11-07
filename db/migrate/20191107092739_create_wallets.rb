class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :account, foreign_key: true
      t.string :c_no         ,null: true, comment: "卡号"
      t.string :c_pw         ,null: true, comment: "密码"
      t.string :pay_limit    ,null: true, comment: "支付限制"
      t.string :limit_circle ,null: true, comment: "限制周期"

      t.string :amount       ,null: true, comment: "周期内支付的数量"
      t.string :type         ,null: true, comment: "类型 BankWallet"
      t.string :state        ,null: false, default: 1, comment:"钱包状态 0 1 启用"

      t.timestamps :circle_updated_at, null:true, comment:'周期更新时间'
      t.timestamps
    end
  end
end
