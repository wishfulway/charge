module Admin
  #
  # 生成用户现金账号充值卡密的地方
  class ServicesController < BaseController

    before_action :set_service, only: [:edit, :update, :destroy]


    include Pagy::Backend
    Pagy::VARS[:items] = 10 # 控制分页显示条
    # admin/service
    def index
      @pagy, @services = pagy(Service.all.order('id desc'))
    end

    def show
    end


    def new
      @service = Service.new
    end


    def edit
    end

    def create
      @service = Service.new(service_params)
      respond_to do |format|
        if @service.save
          format.html { redirect_to admin_services_path, notice: '业务创建成功' }
          format.json { render :show, status: :created, location: @service }
        else
          format.html { render :new }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to admin_services_path, notice: '业务更新成功' }
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
        format.html { redirect_to admin_services_path, notice: '业务删除成功' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :rate, :de_name, :url)
    end

  end
end