class ReportPolicy
  attr_reader :user, :report

  def initialize(user, report=nil)
    @user = user
    @report = report
  end

  def index?
  	user.super_admin? or user.admin? or user.user_report_manager?
  end

  def store?
    user.super_admin? or user.admin? or user.user_report_manager?
  end

  def category?
    user.super_admin? or user.admin? or user.user_report_manager?
  end
end