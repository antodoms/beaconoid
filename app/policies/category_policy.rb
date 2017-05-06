class CategoryPolicy
  attr_reader :user, :category

  def initialize(user, category)
    @user = user
    @category = category
  end

  def index?
  	user.admin? or user.store_manager? or user.beacon_manager?
  end

  def show?
    user.admin? or user.store_manager? or user.beacon_manager?
  end

  def create?
    user.admin? or user.store_manager?
  end

  def new?
    user.admin? or user.store_manager?
  end

  def update?
    user.admin? or user.store_manager?
  end

  def edit?
    user.admin? or user.store_manager?
  end

  def destroy?
    user.admin? or user.store_manager?
  end
end