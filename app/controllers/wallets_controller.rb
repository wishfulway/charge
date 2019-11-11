class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update, :destroy]

  # GET /wallets
  # GET /wallets.json
  def index
    @account = Account.find(params[:account_id])
    @wallets = @account.wallets
  end

  # GET /wallets/1
  # GET /wallets/1.json
  def show
  end

  # GET /wallets/new
  def new
    @account = Account.find(params[:account_id])
    @wallet = @account.wallets.new
    @wallet.type = @account.get_wallet_type
  end

  # GET /wallets/1/edit
  def edit
  end




  # POST /wallets
  # POST /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)
    respond_to do |format|
      if @wallet.save
        format.html { redirect_to @wallet.becomes(Wallet), notice: 'Wallet was successfully created.' }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1
  # PATCH/PUT /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to @wallet, notice: 'Wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1
  # DELETE /wallets/1.json
  def destroy
    account = Account.find(@wallet.account_id)
    @wallet.destroy
    respond_to do |format|
      format.html { redirect_to account_wallets_path(account), notice: '成功删除支付渠道' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      puts "params -- ", params
      @wallet = Wallet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallet_params
      params.require(:wallet).permit(:account_id, :c_no, :c_pw, :p_limit_d_cents, :amount_cents, :type, :state)
    end
end
