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

	    render 'edit'
	  end

	  def destroy
	    @category = Category.find(params[:id])
	    authorize @category

	    @category.destroy
	    redirect_to categories_path, notice: "#{@category.name} has been deleted!" and return
	  end
	private
	  def category_params
	    params.require(:category).permit(:name, :description)
	  end
end
