class UserPolicy
  attr_reader :user, :users

  def initialize(user,users)
    @user = user
    @users = users
  end

  def index?
  	user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end