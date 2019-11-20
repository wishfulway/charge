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

qr_account_type = AccountType.new(name: 'AccountQr', cn_name:'扫码账户')
qr_account_type.save!
qcard_account_type = AccountType.new(name: 'AccountQcard', cn_name:'QQ卡账户')
qcard_account_type.save!
qq_bank_account_type = AccountType.new(name: 'AccountQqBank', cn_name:'银行账户-QQ')
qq_bank_account_type.save!
wx_bank_account_type = AccountType.new(name: 'AccountWxBank', cn_name:'银行账户-微信')
wx_bank_account_type.save!
qb_account_type = AccountType.new(name: 'AccountQb', cn_name:'Q币账户')
qb_account_type.save

# wx_bank_account
xwsd_service = Service.create(name:'炫舞时代金币', de_name:'XWSD', rate:100)
cf_service   = Service.create(name:'穿越火线', de_name:'CYHX', rate:100)
dzs_service = Service.create(name:'斗战神金子', de_name:'DZS', rate:100)
qe_service = Service.create(name:'企鹅电竞', de_name:'QEDJ', rate:10)
nz_service = Service.create(name:'逆战点券', de_name:'NZ_', rate:100)
hzdnf_service = Service.create(name:'黑钻', de_name:'HZDNF', rate:1)
lol_service = Service.create(name:'英雄联盟', de_name:'LOL', rate:100)

# qq_bank_account
dnf_service  = Service.create(name:'地下城与勇士', de_name:'DNF', rate:100)

#qb_account
wyhy_service = Service.create(name:'微云会员', de_name:'WYHY', rate:1, url:'https://pay.qq.com/ipay/index.shtml?c=wyclub')
hhhz_service = Service.create(name:'QQ豪华黄钻月卡', de_name:'QQHHHZ', rate:1, url:'https://pay.qq.com/ipay/index.shtml?n=3&c=xxjzsj')
hhlz_service = Service.create(name:'QQ豪华蓝钻月卡', de_name:'QQHHLZ', rate:1, url:'https://pay.qq.com/ipay/index.shtml?n=3&c=xxzxgp')
txsp_service = Service.create(name:'腾讯视频会员月卡', de_name:'TXSP', rate:1, url:'https://pay.qq.com/ipay/index.shtml?c=txsp')
qqxwzz_service = Service.create(name:'QQ炫舞紫钻月卡', de_name:'QQXWZZ', rate:1, url:'https://pay.qq.com/ipay/index.shtml?n=3&c=qqxwzz')
qqfczz_service = Service.create(name:'QQ飞车紫钻月卡', de_name:'QQFCZZ', rate:1, url:'https://pay.qq.com/ipay/index.shtml?c=qqfczz')

# qr_account
cmdnf_service = Service.create(name:'DNF网页验号', de_name:'CMDNF', rate:100, url:'https://pay.qq.com/ipay/index.shtml?c=dnfdq')
wydnf_service = Service.create(name:'DNF网页扫码', de_name:'WYDNF', rate:100, url:'https://pay.qq.com/ipay/index.shtml?c=dnfdq')
smdnf_service = Service.create(name:'DNF扫码支付', de_name:'SMDNF', rate:100)




AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:xwsd_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:cf_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:dzs_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:qe_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:nz_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:hzdnf_service.id)
AccountTypeService.create(account_type_id: wx_bank_account_type.id, service_id:lol_service.id)

AccountTypeService.create(account_type_id: qq_bank_account_type.id, service_id:dnf_service.id)

AccountTypeService.create(account_type_id: qb_account_type.id, service_id:wyhy_service.id)
AccountTypeService.create(account_type_id: qb_account_type.id, service_id:hhhz_service.id)
AccountTypeService.create(account_type_id: qb_account_type.id, service_id:hhlz_service.id)
AccountTypeService.create(account_type_id: qb_account_type.id, service_id:txsp_service.id)
AccountTypeService.create(account_type_id: qb_account_type.id, service_id:qqxwzz_service.id)
AccountTypeService.create(account_type_id: qb_account_type.id, service_id:qqfczz_service.id)

AccountTypeService.create(account_type_id: qr_account_type.id, service_id:cmdnf_service.id)
AccountTypeService.create(account_type_id: qr_account_type.id, service_id:wydnf_service.id)
AccountTypeService.create(account_type_id: qr_account_type.id, service_id:smdnf_service.id)

if Rails.env.development?
  wg_qq_bank_account = Account.new(user_id:wg.id,
                                account_type_id:qq_bank_account_type.id,
                                name:'测试账户',
                                uin: 666666,
                                pw: "123456",
                                type:qq_bank_account_type.name,
                                state: Account.states[:active])

  wg_qq_bank_account.save!
  wg_qq_bank_account_wallet =  wg_qq_bank_account.wallets.new(c_no:"浙江农信-储蓄卡(0000)", type: 'WalletQqBank')
  wg_qq_bank_account_wallet.c_pw = wg_qq_bank_account.pw.nil? ? wg_qq_bank_account.pw : '456789'
  wg_qq_bank_account_wallet.amount_updated_at = Time.now
  wg_qq_bank_account_wallet.save




end