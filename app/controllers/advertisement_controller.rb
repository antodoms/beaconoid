class AdvertisementController < ApplicationController

	def adList
		@advertisements = Advertisement.all

	end

	def destroy
		Advertisement.find(params[:id]).destroy
		redirect_to :action => 'list'
	end

	def show
		@advertisements = Advertisement.find(params[:id])
	end

	def new
   		@advertisement = Advertisement.new
   		#@advertisements = Advertisement.all
	end

	def create
		@advertisement = Advertisement.new(advertisement_params)
	
   		if @advertisement.save
      		redirect_to :action => 'list'
   		else
      		#@advertisements = Advertisement.all
      		render :action => 'new'
   		end
	end

	def advertisement_params
   		params.require(:advertisements).permit(:aId, :aCategory, :aPrice, :aDescription)
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

	def advertisement_param
   		params.require(:advertisement).permit(:aID, :bCategory, :aPrice, :aDescription)
	end


end
