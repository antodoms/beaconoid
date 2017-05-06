class AdvertisementPolicy
  attr_reader :user, :advertisement

  def initialize(user, advertisement)
    @user = user
    @advertisement = advertisement
  end

  def index?
  	user.admin? or user.store_manager? or user.beacon_manager?
  end

  def show?
    user.admin? or user.store_manager? or user.beacon_manager?
  end

  def create?
    user.admin? or user.beacon_manager?
  end

  def new?
    user.admin? or user.beacon_manager?
  end

  def update?
    user.admin? or user.beacon_manager?
  end

  def edit?
    user.admin? or user.beacon_manager?
  end

  def destroy?
    user.admin? or user.beacon_manager?
  end
end