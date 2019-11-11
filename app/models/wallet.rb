class Wallet < ApplicationRecord
  belongs_to :account


  enum type: {QqBankWallet:'QqBankWallet', WxBankWallet:'WxBankWallet', QbWallet:'QbWallet', QcardWallet:'QcardWallet', QrWallet:'QrWallet'}, _prefix:true

  enum state: {inactive:0, active:1}, _prefix: true

  BANK_WALLET_LIMIT = 300000

  register_currency :cn4
  monetize :p_limit_d_cents, with_currency: :cn4, allow_nil: true
  monetize :amount_cents   , with_currency: :cn4, allow_nil: true


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
    when 'QqBankWallet'
      return 'QQ账户钱包'
    when 'WxBankWallet'
      return '微信账户钱包'
    when 'QbWallet'
      return 'Q币账户钱包'
    when 'QcardWallet'
      return 'QQ卡账户钱包'
    end
  end

  def type_str
    case self.type
    when 'QqBankWallet'
      return 'QQ账户钱包'
    when 'WxBankWallet'
      return '微信账户钱包'
    when 'QbWallet'
      return 'Q币账户钱包'
    when 'QcardWallet'
      return 'QQ卡账户钱包'
    when 'QrWallet'
      return '扫码账户钱包'
    end
  end

  def can_show_limit
    case self.type
    when 'QqBankWallet'
      return true
    when 'WxBankWallet'
      return true
    end
    return false

  end



end
