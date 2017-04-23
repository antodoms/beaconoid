class StaffsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @users = User.all
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def show
    authorize User
  end

  def create
    @user = User.new(user_params)
    authorize @user

    @user.password = "password"
    @user.password_confirmation = "password"

    if @user.save!
      redirect_to staffs_path, notice: "The User has been created!" and return
    end
    render 'new'
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    #binding.pry
    if @user.update_attributes(user_params)
      redirect_to staffs_path, notice: "#{@user.name} has been updated!" and return
    end

    render 'edit'
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy

    redirect_to staffs_path, notice: "#{@user.name} has been deleted!" and return
  end
private
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :role)
  end
end
