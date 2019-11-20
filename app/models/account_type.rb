class AccountType < ApplicationRecord
  has_many :account
  has_many :account_type_services

  # TYPE_NAME = {QrAccount:'QrAccount', QcardAccount:'QcardAccount', BankAccount:'BankAccount', QbAccount:'QbAccount'}


  def self.type_name_cn(name)
    #  limit => #<ActiveRecord::Relation [#<AccountType id: 3, name: "BankAccount", cn_name: "閾惰璐︽埛", created_at: "2019-11-10 09:06:55", updated_at: "2019-11-10 09:06:55">]>
    # first => #<AccountType id: 3, name: "BankAccount", cn_name: "閾惰璐︽埛", created_at: "2019-11-10 09:06:55", updated_at: "2019-11-10 09:06:55">
    account_type = AccountType.where(name: name).first
    account_type.cn_name
  end

  def self.type_opts
    # 1110 修改
    AccountType.all.map{|account_type| [account_type.cn_name, account_type.name]}
    # TYPE_NAME.map{|k, v| [AccountType.type_name_str(v), v]}
  end





end
