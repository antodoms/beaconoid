class CategoriesController < ApplicationController

	def index
		@categories = Category.all
	end

	def new
	  	@category = Category.new
	end

	def show

	end

	def create
	    @category = Category.new(category_params)

	    if @category.save
	      redirect_to categories_path, notice: "The Category has been created!" and return
	    end
	    render 'new'
	end

	  def edit
	    @category = Category.find(params[:id])
	  end

	  def update
	    @category = Category.find(params[:id])

	    if @category.update_attributes(category_params)
	      redirect_to categories_path, notice: "#{@category.name} has been updated!" and return
	    end

	    render 'edit'
	  end

	  def destroy
	    @category = Category.find(params[:id])
	    @category.destroy

	    redirect_to categories_path, notice: "#{@category.name} has been deleted!" and return
	  end
	private
	  def category_params
	    params.require(:category).permit(:name, :description)
	  end
end
