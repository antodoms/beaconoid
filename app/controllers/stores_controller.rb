class StoresController < ApplicationController
  before_action :authenticate_user!

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    if policy(:store).index?
      redirect_to stores_path
    else
      redirect_to dashboard_path
    end
  end
  
  def filter    
    if params[:store_search].present? && params[:store_search][:filter].present?
      redirect_to stores_path(:store_search => params[:store_search][:filter])
    elsif params[:store_search].present? && !params[:store_search][:filter].present?
      redirect_to stores_path(:store_search => "")
    else
      @store = Store.filter_by_name(params[:term]).paginate(page: params[:page], per_page: 10)
      render json: @store.map(&:name)
    end
  end

  def index
    if params[:store_search].present?
      @store = Store.filter_by_name(params[:store_search]).paginate(page: params[:page], per_page: 10)
    else
      @store = Store.paginate(page: params[:page], per_page: 10)
    end
      authorize @store

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
      ActionCable.server.broadcast 'beaconoid:general_report',
        message: [0,0,0,1,0,0],
        user: current_user.id

      redirect_to stores_path, notice: "The Store has been created!" and return
    else
      flash[:error] = @store.validate.html_safe
      redirect_to new_store_path
    end
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

    flash[:error] = @store.validate.html_safe
    redirect_to edit_store_path(@store)
  end

  def destroy
    @store = Store.find(params[:id])
    authorize @store
    #@store.destroy

    @beacons = Beacon.all

    @beacons.each do |beacon|
      if beacon.store_id==@store.id
        redirect_to stores_path, error: "#{@store.name} has not been deleted! Beacons are assigned to this store." and return
      end
    end

    @store.destroy

    # push to redis db

    ActionCable.server.broadcast 'beaconoid:general_report',
      message: [0,0,0,-1,0,0],
      user: current_user.id
      
    redirect_to stores_path, notice: "#{@store.name} has been deleted!" and return
  end


private
  def store_params
    params.require(:store).permit(:name, :unique_id, :image_url, :sales)
  end
end
