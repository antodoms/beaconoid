module Api::V1
  class StoresController < ActionController::API
    #before_action :authenticate_user!
    
    def index
      render json: Store.all
    end

    def show
      render json: Store.find_by(id: params[:id])
    end

  private
    def store_params
      params.require(:store).permit(:name, :code)
    end
  end
end
