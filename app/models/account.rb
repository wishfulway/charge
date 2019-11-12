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



  def inquery_free_order

  end


end
