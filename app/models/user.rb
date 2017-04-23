class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, stretches: 12

  USER_ROLES= ["Admin", "Beacon Manager", "User Report Manager"]

  def admin?
  	self.role == "Admin"
  end

  def beacon_manager?
  	self.role == "Beacon Manager"
  end

  def user_report_manager?
  	self.role == "User Report Manager"
  end

end
