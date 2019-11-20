class AccountQr < Account

  def self.model_name
    Account.model_name
  end


  # 查单函数
  def inquiry_offer
    check_inquiry_access!
    # services = self.account_type.account_type_services.map{|ats|[ats.de_name]}
  end

end