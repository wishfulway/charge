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

qr_account_type = AccountType.new(name: 'QrAccount', cn_name:'扫码账户')
qr_account_type.save!
qcard_account_type = AccountType.new(name: 'QcardAccount', cn_name:'QQ卡账户')
qcard_account_type.save!
qq_bank_account_type = AccountType.new(name: 'QqBankAccount', cn_name:'银行账户-QQ')
qq_bank_account_type.save!
wx_bank_account_type = AccountType.new(name: 'WxBankAccount', cn_name:'银行账户-微信')
wx_bank_account_type.save!
qb_account_type = AccountType.new(name: 'QbAccount', cn_name:'Q币账户')
qb_account_type.save

if Rails.env.development?
  wg_qq_bank_account = Account.new(user_id:wg.id,
                                account_type_id:qq_bank_account_type.id,
                                name:'测试账户',
                                uin: 666666,
                                pw: "123456",
                                type:qq_bank_account_type.name,
                                state: Account.states[:active])

  wg_qq_bank_account.save!
  wg_qq_bank_account_wallet =  wg_qq_bank_account.wallets.new(c_no:"浙江农信-储蓄卡(0000)", type: 'QqBankWallet')
  wg_qq_bank_account_wallet.c_pw = wg_qq_bank_account.pw.nil? ? wg_qq_bank_account.pw : '456789'
  wg_qq_bank_account_wallet.save

end