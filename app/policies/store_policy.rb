class StorePolicy
  attr_reader :user, :store

  def initialize(user, store)
    @user = user
    @store = store
  end

  def index?
  	user.admin? or store_manager? or user.beacon_manager?
  end

  def show?
    user.admin? or store_manager? or user.beacon_manager?
  end

  def create?
    user.admin? or store_manager?
  end

  def new?
    user.admin? or store_manager?
  end

  def update?
    user.admin? or store_manager?
  end

  def edit?
    user.admin? or store_manager?
  end

  def destroy?
    user.admin? or store_manager?
  end
end