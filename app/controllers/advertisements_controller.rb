class AdvertisementsController < ApplicationController

	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to advertisements_path
		else
		  redirect_to dashboard_path
		end
	end

	def index
		@advertisements = Advertisement.all
		authorize @advertisements
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
   			ActionCable.server.broadcast 'beaconoid:general_report',
		      message: [0,0,0,0,0,1],
		      user: current_user.id

   			@advertisements = Advertisement.all
      		redirect_to edit_advertisement_path(@advertisement)
   		else
      		render :action => 'new'
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
      		redirect_to :action => 'edit'
   		else
      		render :action => 'edit'
   		end
   
	end

	def advertisement_params
   		params.require(:advertisement).permit(:name, :category_id, :description, :beacon_id, :price, :image)
	end

	def beacon_param
		params.permit(:beacon_id)
	end


end
