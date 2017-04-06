class BeaconController < ApplicationController

	def list
		@beacons = Beacon.all

	end

	def destroy
		Beacon.find(params[:id]).destroy
		redirect_to :action => 'list'
	end

	def show
		@beacons = Beacon.find(params[:id])
	end

	def new
   		@beacon = Beacon.new
   		@advertisements = Advertisement.all
	end

	def create
		@beacon = Beacon.new(beacon_params)
	
   		if @beacon.save
      		redirect_to :action => 'list'
   		else
      		@advertisements = Advertisement.all
      		render :action => 'new'
   		end
	end

	def beacon_params
   		params.require(:beacons).permit(:bID, :bStore, :aID, :bCategory, :bHits)
	end


	def edit
		@beacon = Beacon.find(params[:id])
   		@advertisements = Advertisement.all
	end

	def update
   		@beacon = Beacon.find(params[:id])
	
   		if @beacon.update_attributes(beacon_param)
      		redirect_to :action => 'show', :id => @beacon
   		else
      		@advertisements = Advertisement.all
      		render :action => 'edit'
   		end
   
	end

	def beacon_param
   		params.require(:beacon).permit(:bID, :bStore, :aID, :bCategory, :bHits)
	end

	



end
