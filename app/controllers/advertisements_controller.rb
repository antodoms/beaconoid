class AdvertisementsController < ApplicationController

	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to advertisements_path
		else
		  redirect_to dashboard_path
		end
	end

	# search method
	def filter
		#binding.pry    
    	if params[:advertisement_search].present? && params[:advertisement_search][:filter].present?
			redirect_to advertisements_path(:advertisement_search => params[:advertisement_search][:filter])
		elsif params[:advertisement_search].present? && !params[:advertisement_search][:filter].present?
			redirect_to advertisements_path(:advertisement_search => "")
		else
			@advertisement = Advertisement.filter_by_name(params[:term]).paginate(page: params[:page], per_page: 10)
			render json: @advertisement.map(&:name)
		end
  	end


	def index
		if params[:advertisement_search].present?
			@advertisement = Advertisement.filter_by_name(params[:advertisement_search]).paginate(page: params[:page], per_page: 10)
		else
			@advertisement = Advertisement.paginate(page: params[:page], per_page: 10)
		end
    	authorize @advertisement
	end

	def destroy
		@advertisement = Advertisement.find(params[:id])
		authorize @advertisement
		
		@advertisement.destroy

		ActionCable.server.broadcast 'beaconoid:general_report',
		    message: [0,0,0,0,0,-1],
		    user: current_user.id

		@advertisements = Advertisement.all
		redirect_to :action => 'index'
	end

	def show
		#binding.pry
		@advertisement = Advertisement.find(params[:id])
		authorize @advertisement

	end

	def new
   		@advertisement = Advertisement.new
   		authorize @advertisement
   		#@advertisements = Advertisement.all
	end

	def create
		#binding.pry
		@advertisement = Advertisement.new(advertisement_params)
		authorize @advertisement

   		if @advertisement.save
   			#push to redis DB 
   			ActionCable.server.broadcast 'beaconoid:general_report',
		      message: [0,0,0,0,0,1],
		      user: current_user.id

   			@advertisements = Advertisement.all
      		redirect_to edit_advertisement_path(@advertisement)
   		else
      		flash[:error] = @advertisement.validate
      		redirect_to new_advertisement_path
   		end
	end


	def edit
		@advertisement = Advertisement.find(params[:id])
		authorize @advertisement
	end

	def update
		#binding.pry
   		@advertisement = Advertisement.find(params[:id])
   		authorize @advertisement
	
   		if @advertisement.update_attributes(advertisement_params)
   			@advertisements = Advertisement.all
      		#redirect_to beacon_path(@advertisement.beacon)
      		redirect_to edit_advertisement_path(@advertisement)
   		else
      		flash[:error] = @advertisement.validate
      		redirect_to edit_advertisement_path(@advertisement)
   		end
   
	end

	def advertisement_params
   		params.require(:advertisement).permit(:name, :category_id, :description, :beacon_id, :price, :image)
	end

	def beacon_param
		params.permit(:beacon_id)
	end


end
