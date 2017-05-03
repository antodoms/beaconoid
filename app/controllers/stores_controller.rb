class StoresController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @stores = Store.all
    authorize @stores
  end

  def new
    @store = Store.new
    authorize @store
  end

  def show

  end

  def create
    @store = Store.new(store_params)
    authorize @store

    if @store.save
      redirect_to stores_path, notice: "The Store has been created!" and return
    end
    render 'new'
  end

  def edit
    @store = Store.find(params[:id])
    authorize @store
  end

  def update
    @store = Store.find(params[:id])
    authorize @store
    
    if @store.update_attributes(store_params)
      redirect_to stores_path, notice: "#{@store.name} has been updated!" and return
    end

    render 'edit'
  end

  def destroy
    @store = Store.find(params[:id])
    authorize @store

    @store.destroy

    redirect_to stores_path, notice: "#{@store.name} has been deleted!" and return
  end
private
  def store_params
    params.require(:store).permit(:name, :unique_id, :image_url)
  end
end
