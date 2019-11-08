class Account < ApplicationRecord
  belongs_to :user
  belongs_to :account_type
  # validates :user_id, presence: true

  has_many :wallets

  enum uin_type: {QQ:'QQ', WX:'WX'}, _prefix: true
  enum state: {inactive:0, active:1}, _prefix: true


  def self.state_str(state)
    case state
    when 'inactive', 0
      return '未激活'
    when 'active', 1
      return '已激活'
    end
  end

  def state_str
    Account.state_str self.state
  end

  def type_str
    AccountType.type_name_str self.type
  end

  def inquery_free_order

  end


end
