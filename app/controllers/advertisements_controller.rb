class AdvertisementsController < ApplicationController

	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:beacon).index?
		  redirect_to advertisements_path
		else
		  redirect_to dashboard_path
		end
	end

	def filter    
    	$flag = true
    	$x = params[:filter_text].to_s
	    $y = params[:filter_tag]
	    redirect_to advertisements_path   
  	end

	def index
		#@advertisements = Advertisement.all
		#authorize @advertisements

		if $flag == true
      		if $y == "advertisement_name"
        		@advertisement = Advertisement.filter_by_advertisement_name("#{$x}") 
      		elsif $y == "beacon_name"
      			@beacon = Beacon.filter_by_beacon_name("#{$x}")
        		@advertisement = Advertisement.filter_by_beacon_id(@beacon.first.id)
      		elsif $y == "category_name"
      			@category = Category.filter_by_category_name("#{$x}")
        		@advertisement = Advertisement.filter_by_category_id(@category.first.id)
      		end
      		$flag = false 
                          
    	else
      		@advertisement = Advertisement.all
    	end
    
    	authorize @advertisement

    	@advertisement = @advertisement.paginate(page: params[:page], per_page: 10)
		
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
