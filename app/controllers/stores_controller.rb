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

    $flag = true
    $x = params[:filter_text].to_s
    $y = params[:filter_tag]
    redirect_to stores_path   
  end

  def index
    #@stores = Store.all
    #authorize @stores

    if $flag == true
      if $y == "id"
        @store = Store.filter_by_store_id("#{$x}") 
      elsif $y == "store_name"
        @store = Store.filter_by_store_name("#{$x}")
      elsif $y == "store_code"
        @store = Store.filter_by_store_code("#{$x}")
      elsif $y == "store_sale"
        @store == Store.filter_by_store_sale("#{$x}")          
      end
      $flag = false 
                          
    else
      @store = Store.all
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
    end
    flash[:error] = "Sorry we can't add this store. Store with same name exists."
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
    #@store.destroy

    @beacons = Beacon.all

    @beacons.each do |beacon|
      if beacon.store_id==@store.id
        redirect_to stores_path, error: "#{@store.name} has not been deleted! Beacons are assigned to this store." and return
      end
    end

    @store.destroy

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
