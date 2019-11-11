class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :show_wallets, :create_wallet]



  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = current_user.accounts.order('id desc')
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit

  end




  # def show_wallets
  #   @wallets = @account.wallets
  # end

  # def create_wallet
  #   @wallet = @account.wallets.new
  #   @wallet.type = @account.get_wallet_type
  #   @wallet.c_pw = !@account.pw.nil? ? @account.pw : nil
  # end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = current_user.accounts.new(account_params).becomes(Account)
    @account.account_type_id = AccountType.where(name: @account.type).first.id
    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: '账户创建成功' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_path, notice: '账户信息修改成功' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: '账户删除成功' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      # state 必须为 string 形式的 定义了 enum
      params.require(:account).permit(:name, :uin, :uin_type, :type, :state)
    end
end
