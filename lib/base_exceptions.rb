module BaseExceptions


  # class OperationError < StandardError
  #   attr_accessor :code
  #   def initialize(code, msg)
  #     @code = code
  #     super(msg)
  #   end
  # end

  class AccessCheckError < StandardError; end

  class NoWalletCanPayError < StandardError; end

  class NoSupplyServiceError < StandardError; end

end