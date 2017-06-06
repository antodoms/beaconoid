class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable, stretches: 12

  validates :password, :presence => { :on => :create }, :length   => { :minimum => 6, :allow_nil => true }, :confirmation => true
  validates_uniqueness_of :email

  USER_ROLES= ["Admin","Store Manager","Beacon Manager", "User Report Manager"]
  SUPER_USER_ROLES = ["Super Admin","Admin","Store Manager","Beacon Manager", "User Report Manager"]

  def self.get_roles(user)
    if user.super_admin?
      SUPER_USER_ROLES
    else
      USER_ROLES
    end
  end

  def super_admin?
    self.role == "Super Admin"
  end

  def admin?
  	self.role == "Admin"
  end

  def store_manager?
    self.role == "Store Manager"
  end
  
  def beacon_manager?
  	self.role == "Beacon Manager"
  end

  def user_report_manager?
  	self.role == "User Report Manager"
  end

end
