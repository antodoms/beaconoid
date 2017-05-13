class CategoriesController < ApplicationController

	def index
		@categories = Category.all
		authorize @categories
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
	    redirect_to categories_path, notice: "#{@category.name} has been deleted!" and return
	  end
	  
	private
	  def category_params
	    params.require(:category).permit(:name, :description)
	  end
end
