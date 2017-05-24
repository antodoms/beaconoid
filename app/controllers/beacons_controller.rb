class BeaconsController < ApplicationController
	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to beacons_path
		else
		  redirect_to dashboard_path
		end
	end

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
      		redirect_to beacons_path, notice: "#{@beacon.name} has been created succesfully" and return
   		else
   			flash[:error] = @beacon.errors.full_messages.to_sentence
      		render :action => 'new'
   		end
	end

	def destroy
		@beacon = Beacon.find(params[:id])
		authorize @beacon

		@advertisements = @beacon.advertisements
		if @advertisements.present?
			redirect_to beacons_path, error: "#{@beacon.name} cannot be deleted. Active advertisements are assigned to this beacon" and return
		end

		@beacon.destroy
		redirect_to _path, notice: "#{@beacon.name} has been deleted" and return
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
   			flash[:error] = @beacon.errors.full_messages.to_sentence
      		render :action => 'edit'
   		end
   
	end

	def beacon_params
   		params.require(:beacon).permit(:name, :current_status, :unique_reference, :latitude, :longitude, :store_id)
	end

	



end
