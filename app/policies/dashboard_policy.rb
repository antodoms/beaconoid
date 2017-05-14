class DashboardPolicy
  attr_reader :user, :dashboard

  def initialize(user,dashboard)
    @user = user
    @users = dashboard
  end

  def index?
  	user.super_admin? or user.admin? or user.store_manager? or user.user_report_manager?
  end

end