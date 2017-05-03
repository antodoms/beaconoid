class DashboardController < ApplicationController


  def index
  	@data = CustomerTracking.get_json(Store.all)
  end
end
