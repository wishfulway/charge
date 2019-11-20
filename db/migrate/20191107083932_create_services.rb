class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|

      t.string :name, null: false, comment: 'Q币充值'
      t.integer :rate, null: false, comment: '比例'
      t.string :de_name, null: false, comment: '设备端名称'
      t.string :url, null: true, comment: '充值url'
      t.integer :priority, default: 100, null: false, comment: "优先级"

      t.timestamps
    end
    add_index :services, [:de_name], unique: true
  end
end
