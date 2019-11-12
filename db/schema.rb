# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_07_092739) do

  create_table "account_type_services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_type_id"
    t.bigint "service_id"
    t.integer "state", default: 1, comment: "on 1, off 0"
    t.integer "interval", default: 0, comment: "可查询间隔 单位为s，0 为无查询间隔"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id", "service_id"], name: "index_account_type_services_on_account_type_id_and_service_id", unique: true
    t.index ["account_type_id"], name: "index_account_type_services_on_account_type_id"
    t.index ["service_id"], name: "index_account_type_services_on_service_id"
  end

  create_table "account_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "cn_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_type_id"
    t.string "name", null: false
    t.string "uin", null: false
    t.string "pw", comment: "账户密码，可以为空"
    t.string "type", null: false
    t.integer "state", default: 1, null: false, comment: "active or not"
    t.integer "amount", default: 0, comment: "支付总金额"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["user_id", "uin", "type"], name: "index_accounts_on_user_id_and_uin_and_type", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "Q币充值"
    t.integer "rate", null: false, comment: "比例"
    t.string "de_name", null: false, comment: "设备端名称"
    t.string "url", comment: "充值url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["de_name"], name: "index_services_on_de_name", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wallets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.string "c_no", comment: "卡号"
    t.string "c_pw", comment: "密码"
    t.bigint "p_limit_d_cents", default: 300000, comment: "支付限制 每日限额"
    t.bigint "amount_cents", default: 0, comment: "周期内支付的数量"
    t.string "type", comment: "类型 BankWallet"
    t.integer "state", default: 1, null: false, comment: "钱包状态 0 1 启用"
    t.datetime "circle_updated_at", comment: "周期更新时间"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_wallets_on_account_id"
    t.index ["c_no", "type"], name: "index_wallets_on_c_no_and_type", unique: true
  end

  add_foreign_key "account_type_services", "account_types"
  add_foreign_key "account_type_services", "services"
  add_foreign_key "accounts", "account_types"
  add_foreign_key "accounts", "users"
  add_foreign_key "wallets", "accounts"
end
