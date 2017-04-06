class BeaconsController < ApplicationController

	def index
		@beacons = Beacon.all
	end

	def new
   		@beacon = Beacon.new
	end

	def create
		@beacon = Beacon.new(beacon_params)
	
   		if @beacon.save
      		redirect_to :action => 'index'
   		else
      		render :action => 'new'
   		end
	end

	def destroy
		Beacon.find(params[:id]).destroy
		redirect_to :action => 'index'
	end

	def show
		@beacon = Beacon.find(params[:id])
	end

	def edit
		@beacon = Beacon.find(params[:id])
	end

	def update
   		@beacon = Beacon.find(params[:id])
	
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
