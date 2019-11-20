class Wallet < ApplicationRecord
  belongs_to :account

  attr_accessor :can_pay_cents

  validates :c_no, uniqueness: { scope: :type,
                                message: "同类型钱包，卡号不能重复" }
  enum state: {inactive:0, active:1}, _prefix: true

  BANK_WALLET_LIMIT = 3000 * 100
  BANK_WALLET_RESERVE = 10 * 100
  DEFAULT_WALLET_PRIORITY = 100

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

  # def self.get_account_wallet!(account, pay_cents)
  #   wallet_arr = account.wallets.where("p_limit_d_cents - amount_cents >= ? and amount_cents < p_limit_d_cents", pay_cents).order("priority, created_at").limit(10)
  #   # 如果 有可以全额支付的wallet
  #   if !wallet_arr.blank?
  #     # 选择 顶部wallet
  #     wallet = wallet_arr[0]
  #     # 改变 wallet 状态
  #     wallet.after_chosen! pay_cents
  #     #   如果没有可全额支付的wallet
  #   else
  #     # 按照剩余可支付金额 排序wallets
  #     wallet_arr_not_enough = self.wallets.where("amount_cents < p_limit_d_cents").order("amount_cents DESC, priority, created_at").limit(10)
  #     # 如果 排序的wallets 为空
  #     if wallet_arr_not_enough.blank?
  #       raise NoWalletCanPayError, "ACCOUNT_ERROR: #{account.id} - #{account.uin} - 没有可支付的卡"
  #     end
  #     # 选择 顶部wallet
  #     wallet =  wallet_arr_not_enough[0]
  #     # 改变 wallet 状态
  #     wallet.after_chosen!
  #   end
  #   wallet
  # end


  # change object
  # 被选中之后改变wallet状态
  # @params pay_cents 支付 cents 数量 integer
  def after_chosen!(pay_cents = nil)
    can_pay_cents = pay_cents.nil? ? self.p_limit_d_cents - self.amount_cents : pay_cents
    # 可支付金额
    self.can_pay_cents = can_pay_cents
    # 修改已支付金额
    self.amount_cents += can_pay_cents

    self.amount_updated_at = Time.now
    # 更新
    self.save!
  end




end
