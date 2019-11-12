class AccountTypeService < ApplicationRecord
  belongs_to :account_type
  belongs_to :service

  enum state: {off: 0, on: 1}, _prefix: true


  def account_type_cn
    return AccountType.find(self.account_type_id).cn_name
  end

  def service_cn
    return Service.find(self.service_id).name
  end

  def service_de_name
    return Service.find(self.service_id).de_name
  end

  def self.state_cn(state)
    case state
    when 'off', 0
      return '不接单'
    when 'on',  1
      return '接单中'
    end

  end

  def self.state_opts
    AccountTypeService.states.map{|k ,v| [AccountTypeService.state_cn(v), k ]}
  end

end
