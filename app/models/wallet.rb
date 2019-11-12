class Wallet < ApplicationRecord
  belongs_to :account

  validates :c_no, uniqueness: { scope: :type,
                                message: "同类型钱包，卡号不能重复" }
  enum state: {inactive:0, active:1}, _prefix: true

  BANK_WALLET_LIMIT = 300000

  register_currency :cn2
  monetize :p_limit_d_cents, with_currency: :cn2, allow_nil: true
  monetize :amount_cents, with_currency: :cn2, allow_nil: true

  # qb 账户


  def self.state_str(state)
    case state
    when 'active', 1
      return '已激活'
    when 'inactive', 0
      return '未激活'
    end
  end

  def state_str
    puts " --- ", self.inspect
    Wallet.state_str self.state
  end

  def self.state_opts
    Wallet.states.map{|k, v| [Wallet.state_str(v), k]}
  end


  def self.type_str(type)
    case type
    when 'WalletQqBank'
      return 'QQ账户钱包'
    when 'WalletWxBank'
      return '微信账户钱包'
    when 'WalletQb'
      return 'Q币账户钱包'
    when 'WalletQcard'
      return 'QQ卡账户钱包'
    end
  end

  def type_str
    case self.type
    when 'WalletQqBank'
      return 'QQ账户钱包支付'
    when 'WalletWxBank'
      return '微信账户钱包支付'
    when 'WalletQb'
      return 'Q币账户钱包支付'
    when 'WalletQcard'
      return 'QQ卡账户钱包支付'
    when 'WalletQr'
      return '扫码账户钱包支付'
    end
  end

  def can_show_limit
    case self.type
    when 'WalletQqBank'
      return true
    when 'WalletWxBank'
      return true
    end
    return false

  end




end
