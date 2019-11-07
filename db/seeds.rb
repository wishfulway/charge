# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# 平台管理员账号
admin = User.new(id: Account::ADMIN_ID, username: 'admin', email: 'admin@fire-i.com', password: '123456', nickname: '管理员')
admin.skip_confirmation!
admin.save!
# 测试账号
wg = User.new(username: 'wangg', email: '363309946@qq.com',  password: '123456', nickname: '笨笨点卡')
wg.skip_confirmation!
wg.save!


if Rails.env.development?


end