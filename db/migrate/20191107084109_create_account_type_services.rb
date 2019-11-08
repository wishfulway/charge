class CreateAccountTypeServices < ActiveRecord::Migration[5.2]
  def change
    create_table :account_type_services do |t|
      t.references :account_type, foreign_key: true
      t.references :service, foreign_key: true

      t.integer :state, default: 0, comment: 'on, off'
      t.integer :interval, default: 0, comment: '可查询间隔 单位为s，0 为无查询间隔'


      t.timestamps
    end

    add_index :account_type_services, [:account_type_id, :service_id], unique: true
  end
end
