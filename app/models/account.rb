require "#{Rails.root}/lib/base_exceptions"

class Account < ApplicationRecord
  belongs_to :user
  belongs_to :account_type
  # validates :user_id, presence: true
  validates :name, presence: true
  validates :uin, presence: true, uniqueness: { scope: :type,
                                 message: "同类型账户下，账户号码不能重复" }

  has_many :wallets

  # enum uin_type: {QQ:'QQ', WX:'WX'}, _prefix: true
  enum state: {inactive:0, active:1}, _prefix: true



  def self.state_str(state)
    case state
    when 'active', 1
      return '已激活'
    when 'inactive', 0
      return '未激活'
    end
  end

  def state_str
    Account.state_str self.state
  end

  def self.state_opts
    Account.states.map{|k, v| [Account.state_str(v), k]}
  end


  def type_str
    AccountType.type_name_cn self.type
  end

  def new_wallet
    type = case self.type
           when 'AccountQr'
             'WalletQr'
           when 'AccountQqBank'
             "WalletQqBank"
           when 'AccountWxBank'
             "WalletWxBank"
           when 'AccountQcard'
             "WalletQcard"
           end

    c_pw = !self.pw.nil? ? self.pw : nil
    self.wallets.new(type: type, c_pw: c_pw)
  end

  # 子类实现 对外暴露的接口 抽象方法
  def inquiry_offer

  end


  #  单元测试需要暴露 实际为 protected 方法

  # 获取可查询的服务数组
  # return service_arr
  def get_inquiry_service_arr!
    service_arr = []
    self.account_type.account_type_services.each do |ats|
      # TODO service查找频率限制 满足条件才能进入 service_arr
      service_arr << ats.service
    end
    if service_arr.blank?
      raise BaseExceptions::NoSupplyServiceError, "ACCOUNT_ERROR: #{self.id} - #{self.uin} - 当前账户本次查询没有可支持的业务"
    end
    service_arr
  end

  # 获取可支付的钱包数组 - 子类实现 抽象方法 - 不用对外暴露
  # @params pay_cents 支付 cents 数量 integer
  # @return wallet
  def choose_wallet!(pay_cents)

  end






  protected

  # 检查账户是否有权限查单
  # 没有权限直接抛出异常
  def check_inquiry_access!
    if self.state_inactive?
      raise BaseExceptions::AccessCheckError, "ACCOUNT_ERROR: #{self.id} - #{self.uin} - 当前账户为未激活状态-无法查单"
    end
  end


end
