class CategoriesController < ApplicationController

	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
		if policy(:category).index?
		  redirect_to categories_path
		else
		  redirect_to dashboard_path
		end
	end

	def filter		

		$flag = true
		$x = params[:filter_text].to_s
		$y = params[:filter_tag]
		redirect_to categories_path		
	end


	def index
		#@categories = Category.all
		#authorize @categories

		if $flag == true
			if $y == "id"
				@category = Category.filter_by_id("#{$x}") 
			elsif $y == "category"
				@category = Category.filter_by_category_name("#{$x}")
			elsif $y == "description"
				@category = Category.filter_by_description("#{$x}")
			end
			$flag = false 
													
		else
			@category = Category.all
		end
		
		authorize @category
	end

	def new
	  	@category = Category.new
	  	authorize @category
	end

	def show
		authorize Category
	end

	def create
	    @category = Category.new(category_params)
	    authorize @category

	    if @category.save
	    	ActionCable.server.broadcast 'beaconoid:general_report',
		      message: [0,0,0,0,1,0],
		      user: current_user.id
	      redirect_to categories_path, notice: "The Category has been created!" and return
	    end

		flash[:message] = "Sorry we can't add this category. Category with same name exists."
	    render 'new'
	end

	  def edit
	    @category = Category.find(params[:id])
	    authorize @category
	  end

	  def update
	    @category = Category.find(params[:id])
	    authorize @category

	    if @category.update_attributes(category_params)
	      	redirect_to categories_path, notice: "#{@category.name} has been updated!" and return
	    end
	    flash[:error] = @category.errors.full_messages.to_sentence
	    render 'edit'
	  end

	  def destroy
	    @category = Category.find(params[:id])
	    authorize @category

	    @advertisements = @category.advertisements
	    if @advertisements.present?
	    	redirect_to categories_path, error: "#{@category.name} cannot be deleted. Active advertisements have been assigned to this category." and return
	    end

	    @category.destroy
	    ActionCable.server.broadcast 'beaconoid:general_report',
		      message: [0,0,0,0,-1,0],
		      user: current_user.id

	    redirect_to categories_path, notice: "#{@category.name} has been deleted!" and return
	  end
	  
	private
	  def category_params
	    params.require(:category).permit(:name, :description)
	  end
end
