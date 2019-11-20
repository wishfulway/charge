require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  def prepare_user
    @worker1 = users(:worker1)
  end

  def prepare_account
    @worker1_account_qq_Bank = accounts(:worker1_account_qq_Bank)
    @worker1_account_wx_Bank = accounts(:worker1_account_wx_Bank)
  end

  def prepare_offer
    @worker1 = users(:worker1)
  end

  test "可获取用户全部账户" do
    prepare_user
    assert @worker1.accounts.size == 4
  end

  test "账户未激活状态-无法查询订单" do
    prepare_account
    @worker1_account_qq_Bank.state = Account.states['inactive']
    @worker1_account_qq_Bank.save!
    @worker1_account_qq_Bank.reload
    begin
      @worker1_account_qq_Bank.inquiry_offer
    rescue Exception => e
      assert !e.blank?
    end
  end

  test "账户可以查询到查询间隔内支持的业务" do
    prepare_account
    service_arr = @worker1_account_wx_Bank.get_inquiry_service_arr!
    assert !service_arr.nil?
  end

  test "账户不能不满足查询间隔条件的业务" do


  end



  test "账户可以按照支持的业务的优先级-查询到空闲状态的且满足单笔支付限额的订单" do


  end


  test "账户查询到订单之后订单状态由空闲变为取卡中" do
  #   offer after_chosen

  end

  test "账户可以按照指定的金额按照优先级排序获取钱包中可以全额支付的支付渠道-包含可支付金额属性" do
    prepare_account
    pay_cents = 100
    wallet = @worker1_account_qq_Bank.choose_wallet! pay_cents
    puts wallet.inspect
    # assert wallet.amount_cents == pay_cents
    # assert wallet.can_pay_cents == pay_cents
    # assert wallet.priority < Wallet::DEFAULT_WALLET_PRIORITY
  end

  test "账户可以按照指定的金额按照优先级排序获取钱包中可以部分支付的支付渠道-包含可支付金额属性" do
    # prepare_account
    # pay_cents = Wallet::BANK_WALLET_LIMIT + 100
    # wallet = @worker1_account_qq_Bank.choose_wallet! pay_cents
    # puts pay_cents
    # puts wallet.inspect
    # puts wallet.can_pay_cents
      # assert wallet.amount_cents == pay_cents
    # assert wallet.can_pay_cents == pay_cents
    # assert wallet.priority < Wallet::DEFAULT_WALLET_PRIORITY
  end



  test "账户可以按照指定的金额获取钱包中的支付渠道-将支付渠道的剩余支付金额修改为当前值减去指定金额" do


  end


  test "账户获取到支付渠道之后将订单的剩余支付金额更新为当前值减去支付渠道的可支付金额" do

  end

  test "账户获取到支付渠道之后按照支付渠道可支付的将订单状态由取卡中变为繁忙" do

  end

  test "账户没有获取到支付渠道要将订单状态由取卡中改为空闲" do

  end



end
