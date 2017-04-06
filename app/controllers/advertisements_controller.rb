class AdvertisementsController < ApplicationController

	def index
		@advertisements = Advertisement.all

	end

	def destroy
		Advertisement.find(params[:id]).destroy
		redirect_to :action => 'list'
	end

	def show
		#binding.pry
		@advertisements = Advertisement.find(params[:id])
	end

	def new
   		@advertisement = Advertisement.new(beacon_param)
   		#@advertisements = Advertisement.all
	end

	def create
		#binding.pry
		@advertisement = Advertisement.new(advertisement_params)
	
   		if @advertisement.save
      		redirect_to :action => 'index'
   		else
      		#@advertisements = Advertisement.all
      		render :action => 'new'
   		end
	end


	def edit
		@advertisement = Advertisement.find(params[:id])
   		@advertisements = Advertisement.all
	end

	def update
   		@advertisement = Advertisement.find(params[:id])
	
   		if @advertisement.update_attributes(advertisement_param)
      		redirect_to :action => 'show', :id => @advertisement
   		else
      		@advertisements = Advertisement.all
      		render :action => 'edit'
   		end
   
	end

	def advertisement_params
   		params.require(:advertisement).permit(:name, :category_id, :description, :beacon_id)
	end

	def beacon_param
		params.permit(:beacon_id)
	end


end
