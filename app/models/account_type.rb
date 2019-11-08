class AccountType < ApplicationRecord
  has_many :account

  TYPE_NAME = {QrAccount:'QrAccount', QcardAccount:'QcardAccount', BankAccount:'BankAccount', QbAccount:'QbAccount'}


  def self.type_name_str(name)
    case name
    when TYPE_NAME[:QrAccount]
      return '扫码账户'
    when TYPE_NAME[:QcardAccount]
      return 'QQ卡账户'
    when TYPE_NAME[:BankAccount]
      return '银行账户'
    when TYPE_NAME[:QbAccount]
      return 'Q币账户'
    end
  end

  def self.type_opts
    TYPE_NAME.map{|k, v| [AccountType.type_name_str(v), v]}
  end





end
