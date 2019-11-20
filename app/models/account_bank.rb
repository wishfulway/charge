class AccountBank < Account

  def self.model_name
    Account.model_name
  end



  # 查单函数
  # @return wallet
  def inquiry_offer
    # 是否有权限查询订单
    check_inquiry_access!
    # 获取可查询的 service arr
    service_arr = get_inquiry_service_arr!
    # TODO 按照 service_arr中指定的优先级获取free状态的offer 如果没有则抛异常 内部调用 offer.after_chosen
    offer = Offer.get_free_offer! service_arr
    # 按照offer的金额拿卡 没拿到卡 抛异常
    wallet = choose_wallet! offer.reamined_buy_num
    # 拿卡之后 更新offer信息 此处 修改 object
    offer.after_choose_wallet! wallet
    # 返回offer 在controller层面 调用 offer的 to_api_new_offer_hash 然后发送即可
    offer
  end


  # 获取可支付的钱包数组 没取到卡 抛异常
  # bank的account 选卡 无法 将选卡流程封装在wallet中 因为是在多张卡中选择一张 只能是类方法
  # @params pay_cents 支付 cents 数量 integer
  # @return wallet
  def choose_wallet!(offer)
    #  如果不是拆单的 offer
    # 是今天日期 并且额度够的 或者不是今天日期的
    # 查找剩余额度 大于等于 待支付额度的 wallet(即可全额支付的wallet) 按照优先级排序
    pay_cents = offer.current_buy_num
    if offer.is_split?
      # 如果是拆单的 只要是今天的 还未到达支付限制的拿出一个即可
      wallet = self.wallets.where("(amount_cents < p_limit_d_cents and to_days(amount_updated_at) = ? ) or ( to_days(amount_updated_at) != ? )", Time.now.day, Time.now.day).order("amount_cents DESC, priority, created_at").limit(1)
    else
      # 如果不是拆单的 必须拿出一个 未达到支付限制 并且能全额支付的
      wallet = self.wallets.where("(p_limit_d_cents - amount_cents >= ? and amount_cents < p_limit_d_cents and to_days(amount_updated_at) = ? ) or ( to_days(amount_updated_at) != ? )", pay_cents, Time.now.day, Time.now.day).order("priority, created_at").limit(1)
    end
    wallet.after_chosen! pay_cents

    # wallet.after_chosen!
    # # 如果 有可以全额支付的wallet
    # if !wallet_arr.blank?
    #   # 选择 顶部wallet
    #   wallet = wallet_arr[0]
    #   # 改变 wallet 状态
    #   wallet.after_chosen! pay_cents
    #   #   如果没有可全额支付的wallet
    # else
    #   # 按照剩余可支付金额 排序wallets
    #   wallet_arr_not_enough = self.wallets.where("amount_cents < p_limit_d_cents").order("amount_cents DESC, priority, created_at").limit(10)
    #   # 如果 排序的wallets 为空
    #   if wallet_arr_not_enough.blank?
    #     raise NoWalletCanPayError, "ACCOUNT_ERROR: #{self.id} - #{self.uin} - 没有可支付的卡"
    #   end
    #   # 选择 顶部wallet
    #   wallet =  wallet_arr_not_enough[0]
    #   # 改变 wallet 状态
    #   wallet.after_chosen!
    # end
    # 返回
    wallet
  end


end