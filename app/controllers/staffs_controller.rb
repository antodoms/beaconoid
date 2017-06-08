class StaffsController < ApplicationController

  before_action :authenticate_user!

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    if policy(:user).index?
      redirect_to staffs_path
    else
      redirect_to dashboard_path
    end
  end
  
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

    if (User::USER_ROLES.include? (@user.role)) && @user.save
      redirect_to staffs_path, notice: "The User has been created!" and return
    else
      flash[:error] = @user.validate
      redirect_to new_staff_path
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    authorize @user
    @user.assign_attributes(user_params)

    if (User.get_roles(current_user).include? (@user.role)) && @user.save
      redirect_to staffs_path, notice: "#{@user.name} has been updated!" and return
    else
      flash[:error] = @user.validate
      redirect_to edit_staff_path(@user)
    end
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
