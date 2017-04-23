class StorePolicy
  attr_reader :user, :store

  def initialize(user, store)
    @user = user
    @store = store
  end

  def index?
  	user.admin? or user.beacon_manager?
  end

  def show?
    user.admin? or user.beacon_manager?
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