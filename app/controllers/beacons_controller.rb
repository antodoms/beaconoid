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
   			flash[:message] = "Sorry we can't add this beacon. Beacon with same name exists."
      		render :action => 'new'
   		end
	end

	def destroy
		@beacon = Beacon.find(params[:id])
		authorize @beacon

		@advertisements = Advertisement.all
		@advertisements.each do |advertisement|
			if advertisement.beacon_id==@beacon.id
				redirect_to beacons_path, notice: "#{@beacon.name} has not been deleted. Active advertisements are assigned to this beacon" and return
			end
		end

		@beacon.destroy
		redirect_to stores_path, notice: "#{@beacon.name} has been deleted" and return
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
