module Admin

  class AccountTypeServicesController < BaseController
    before_action :set_account_type_service, only: [:edit, :update, :destroy]

    include Pagy::Backend
    Pagy::VARS[:items] = 10 # 控制分页显示条

    # GET /account_type_services
    # GET /account_type_services.json
    def index
      @pagy, @account_type_services = pagy AccountTypeService.all.order('id desc')
    end

    # GET /account_type_services/1
    # GET /account_type_services/1.json
    def show
    end

    # GET /account_type_services/new
    def new
      @account_type_service = AccountTypeService.new
    end

    # GET /account_type_services/1/edit
    def edit
    end

    # POST /account_type_services
    # POST /account_type_services.json
    def create
      @account_type_service = AccountTypeService.new(account_type_service_params)
      respond_to do |format|
        if @account_type_service.save
          format.html { redirect_to admin_account_type_services_path, notice: '创建成功' }
          format.json { render :show, status: :created, location: @account_type_service }
        else
          format.html { render :new }
          format.json { render json: @account_type_service.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /account_type_services/1
    # PATCH/PUT /account_type_services/1.json
    def update
      respond_to do |format|
        if @account_type_service.update(account_type_service_params)
          format.html { redirect_to admin_account_type_services_path, notice: '更新成功' }
          format.json { render :show, status: :ok, location: @account_type_service }
        else
          format.html { render :edit }
          format.json { render json: @account_type_service.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /account_type_services/1
    # DELETE /account_type_services/1.json
    def destroy
      @account_type_service.destroy
      respond_to do |format|
        format.html { redirect_to admin_account_type_services_path, notice: '删除成功' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_type_service
      @account_type_service = AccountTypeService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_type_service_params
      params.require(:account_type_service).permit(:account_type_id, :service_id, :state, :interval)
    end
  end
end

