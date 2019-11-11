class Account < ApplicationRecord
  belongs_to :user
  belongs_to :account_type
  # validates :user_id, presence: true

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

  def get_wallet_type
    case self.type
    when 'QrAccount'
      return Wallet.types[:QrWallet]
    when 'QqBankAccount'
      return Wallet.types[:QqBankWallet]
    when 'WxBankAccount'
      return Wallet.types[:WxBankWallet]
    when 'QcardAccount'
      return Wallet.types[:QcardWallet]
    end
  end


  def inquery_free_order

  end


end
