class BeaconsController < ApplicationController
	def user_not_authorized
		flash[:xerror] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to beacons_path
		else
		  redirect_to dashboard_path
		end
	end

	def filter		

		$flag = true
		$x = params[:filter_text].to_s
		$y = params[:filter_tag]
		redirect_to beacons_path
		

	end

	def index
		#@beacons = Beacon.all
		#authorize @beacons

		if $flag == true
			if $y == "name"
				@beacons = Beacon.filter_by_beacon_name("#{$x}") 
			elsif $y == "unique_reference"
				@beacons = Beacon.filter_by_reference("#{$x}")
			elsif $y == "store_name"
				@store = Store.filter_by_store_name("#{$x}")
				if(!@store.present?)
					$flag = false
					redirect_to beacons_path, error: "No beacons found." and return
				else
					@beacons = Beacon.filter_by_store_id(@store.first.id)
				end
			elsif $y == "status"
				@beacons = Beacon.filter_by_status("#{$x}")
			end
			$flag = false 
													
		else
			@beacons = Beacon.all
		end
		
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
