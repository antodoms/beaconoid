class BeaconPolicy
  attr_reader :user, :beacon

  def initialize(user, beacon)
    @user = user
    @beacon = beacon
  end

  def index?
  	user.admin? or user.beacon_manager?
  end

  def show?
    user.admin? or user.beacon_manager?
  end

  def create?
    user.beacon_manager?
  end

  def new?
    user.beacon_manager?
  end

  def update?
    user.beacon_manager?
  end

  def edit?
    user.beacon_manager?
  end

  def destroy?
    user.beacon_manager?
  end
end