class BeaconsController < ApplicationController

	def index
		@beacons = Beacon.all
		authorize @beacons
	end

	def new
   		@beacon = Beacon.new
   		authorize @beacon
	end

	def create
		@beacon = Beacon.new(beacon_params)
		authorize @beacon
	
   		if @beacon.save
      		redirect_to :action => 'index'
   		else
      		render :action => 'new'
   		end
	end

	def destroy
		@beacon = Beacon.find(params[:id])
		authorize @beacon

		@beacon.destroy
		redirect_to :action => 'index'
	end

	def show
		@beacon = Beacon.find(params[:id])
		authorize @beacon
	end

	def edit
		@beacon = Beacon.find(params[:id])
		authorize @beacon
	end

	def update
   		@beacon = Beacon.find(params[:id])
   		authorize @beacon
	
   		if @beacon.update_attributes(beacon_params)
      		redirect_to :action => 'index'
   		else
      		render :action => 'edit'
   		end
   
	end

	def beacon_params
   		params.require(:beacon).permit(:name, :current_status, :unique_reference, :latitude, :longitude, :store_id)
	end

	



end
