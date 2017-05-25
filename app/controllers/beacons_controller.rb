class BeaconsController < ApplicationController
	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to beacons_path
		else
		  redirect_to dashboard_path
		end
	end

	def create_request
		Typhoeus::Request.new(
	      "https://api.kontakt.io/device",
	      method: :get,
	      #body: xml_body,
	      headers: {
	         "Accept" => "application/vnd.com.kontakt+json;version=10",
	         "Api-Key" => "#{ENV["KONTAKT_API_KEY"]}",
	        "Content-Type" => "application/x-www-form-urlencoded",
	        "User-Agent" => "beaconoid/1.0"
	      }
	    )
	end

	def index
		json_data = JSON.parse(create_request.run.response_body)["devices"]
		
		@registered_list = []
		@unregistered_list = []
		@other_list = []

		json_data.each do |beacon_info|
			unique_reference = "#{beacon_info["instanceId"]}#{beacon_info["namespace"]}"
			beacon = Beacon.find_by(:unique_reference => unique_reference)
			if beacon.present?
				beacon.name = beacon_info["uniqueId"]
				beacon.longitude = beacon_info["lng"] if beacon_info["lng"].present?
				beacon.latitude = beacon_info["lat"] if beacon_info["lat"].present?
				beacon.save
				@registered_list << beacon
			else
				@unregistered_list << Beacon.new(:unique_reference => unique_reference, :name => beacon_info["uniqueId"],:longitude => beacon_info["lng"], :latitude => beacon_info["lat"])
			end
		end

		@other_list = Beacon.where.not(:id => @registered_list.pluck(:id))

		authorize @other_list
	end

	def new
   		@beacon = Beacon.new
   		if params[:name].present?
   			@beacon.name = params[:name]
   		end
   		if params[:unique_reference].present?
   			@beacon.unique_reference = params[:unique_reference]
   		end
   		if params[:longitude].present?
   			@beacon.longitude = params[:longitude]
   		end
   		if params[:latitude].present?
   			@beacon.longitude = params[:latitude]
   		end

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
		redirect_to beacons_path, notice: "#{@beacon.name} has been deleted" and return
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
