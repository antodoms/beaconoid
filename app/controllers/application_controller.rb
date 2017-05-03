class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def dashboard

  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    #binding.pry
    redirect_to dashboard_path
  end
  
end
