module Admin
  #
  # 生成用户现金账号充值卡密的地方
  class UsersController < BaseController

    # admin/service
    def index
      @users = User.all
    end

    def show
    end


    def new
      @service = Service.new
    end


    def edit
    end

    def create
      respond_to do |format|
        if @service.save
          format.html { redirect_to @service, notice: 'Account type service was successfully created.' }
          format.json { render :show, status: :created, location: @service }
        else
          format.html { render :new }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
      respond_to do |format|
        if @service.update(account_type_service_params)
          format.html { redirect_to @service, notice: 'Account type service was successfully updated.' }
          format.json { render :show, status: :ok, location: @service }
        else
          format.html { render :edit }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @service.destroy
      respond_to do |format|
        format.html { redirect_to @service, notice: 'Account type service was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


  end
end