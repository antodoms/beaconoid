class UserPolicy
  attr_reader :user, :users

  def initialize(user,users)
    @user = user
    @users = users
  end

  def index?
  	user.super_admin? or user.admin?
  end

  def show?
    user.super_admin? or user.admin?
  end

  def create?
    user.super_admin? or (user.admin? && (!users.admin? && !users.super_admin?))
  end

  def new?
    user.super_admin? or user.admin?
  end

  def update?
    user.super_admin? or (user.admin? && (!users.admin? && !users.super_admin?))
  end

  def edit?
    user.super_admin? or user.admin?
  end

  def destroy?
    user.super_admin? or (user.admin? && (!users.admin? && !users.super_admin?))
  end
end