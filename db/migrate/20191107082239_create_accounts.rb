class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.references :account_type, foreign_key: true
      t.string :name,   null: false
      t.string :uin
      t.string :uin_type #QQ WX
      t.string :type,   null: false #
      t.integer :state, null: false, default: 1, comment: "active or not"
      t.integer :amount, null: true,  default: 0, comment:"支付总金额"

      t.timestamps
    end
    add_index :accounts, [:user_id, :uin], unique: true
  end
end
