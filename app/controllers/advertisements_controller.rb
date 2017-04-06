class AdvertisementsController < ApplicationController

	def index
		@advertisements = Advertisement.all

	end

	def destroy
		Advertisement.find(params[:id]).destroy
		@advertisements = Advertisement.all
		redirect_to :action => 'index'
	end

	def show
		#binding.pry
		@advertisement = Advertisement.find(params[:id])
	end

	def new
   		@advertisement = Advertisement.new(beacon_param)
   		#@advertisements = Advertisement.all
	end

	def create
		#binding.pry
		@advertisement = Advertisement.new(advertisement_params)
	
   		if @advertisement.save
   			@advertisements = Advertisement.all
      		redirect_to :action => 'index'
   		else
      		render :action => 'new'
   		end
	end


	def edit
		@advertisement = Advertisement.find(params[:id])
	end

	def update
		#binding.pry
   		@advertisement = Advertisement.find(params[:id])
	
   		if @advertisement.update_attributes(advertisement_params)
   			@advertisements = Advertisement.all
      		redirect_to beacon_path(@advertisement.beacon)
   		else
      		render :action => 'edit'
   		end
   
	end

	def advertisement_params
   		params.require(:advertisement).permit(:name, :category_id, :description, :beacon_id, :price)
	end

	def beacon_param
		params.permit(:beacon_id)
	end


end
