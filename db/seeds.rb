# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# # 平台管理员账号
admin = User.new(id: User::ADMIN_ID, username: 'admin', email: 'admin@fire-i.com', password: '123456', nickname: '管理员')
admin.save!
# 测试账号
wg = User.new(username: 'wangg', email: '363309946@qq.com',  password: '123456', nickname: '笨笨点卡')
wg.save!

qr_account_type = AccountType.new(name: 'QrAccount')
qr_account_type.save!
qcard_account_type = AccountType.new(name: 'QcardAccount')
qcard_account_type.save!
bank_account_type = AccountType.new(name: 'BankAccount')
bank_account_type.save
qb_account_type = AccountType.new(name: 'QbAccount')
qb_account_type.save

if Rails.env.development?
  wg_bank_account = Account.new(user_id:wg.id,
                                account_type_id:bank_account_type.id,
                                name:'测试账户',
                                uin: 666666,
                                uin_type: Account.uin_types[:QQ],
                                type:bank_account_type.name,
                                state: Account.states[:active])

  wg_bank_account.save!
end