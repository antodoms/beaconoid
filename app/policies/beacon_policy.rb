class BeaconPolicy
  attr_reader :user, :beacon

  def initialize(user, beacon)
    @user = user
    @beacon = beacon
  end

  def index?
  	user.super_admin? or user.admin? or user.store_manager? or user.beacon_manager?
  end

  def show?
    user.super_admin? or user.admin? or user.store_manager? or user.beacon_manager?
  end

  def create?
    user.super_admin? or user.admin? or user.beacon_manager?
  end

  def new?
    user.super_admin? or user.admin? or user.beacon_manager?
  end

  def update?
    user.super_admin? or user.admin? or user.beacon_manager?
  end

  def edit?
    user.super_admin? or user.admin? or user.beacon_manager?
  end

  def destroy?
    user.super_admin? or user.admin? or user.beacon_manager?
  end
end