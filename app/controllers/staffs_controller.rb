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
    # @user.password = "password"
    # @user.password_confirmation = "password"

    if (User::USER_ROLES.include? (@user.role)) && @user.save
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
    @user.assign_attributes(user_params)

    if (User.get_roles(current_user).include? (@user.role)) && @user.save
      redirect_to staffs_path, notice: "#{@user.name} has been updated!" and return
    end
    error = ""
    @user.errors.full_messages.each do |err|
      error << ((err.present? && error.present?)? "<br>#{err}" : "#{err}")
    end
    flash[:error] = error.html_safe
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
    params.require(:user).permit(:name, :nickname, :email, :role, :password, :password_confirmation)
  end
end
