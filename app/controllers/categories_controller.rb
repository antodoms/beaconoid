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
		if params[:category_search].present? && params[:category_search][:filter].present?
			redirect_to categories_path(:category_search => params[:category_search][:filter])
		elsif params[:category_search].present? && !params[:category_search][:filter].present?
			redirect_to categories_path(:category_search => "")
		else
			@categories = Category.filter_by_name(params[:term]).paginate(page: params[:page], per_page: 10)
			render json: @categories.map(&:name)
		end
	end


	def index
		#binding.pry
		if params[:category_search].present?
			@category = Category.filter_by_name(params[:category_search]).paginate(page: params[:page], per_page: 10)
		else
			@category = Category.paginate(page: params[:page], per_page: 10)
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
	    else
	    	flash[:error] = @category.validate
	    	redirect_to new_category_path
	    end
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
	    else
	    	flash[:error] = @category.validate
	    	redirect_to edit_category_path
	    end
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
