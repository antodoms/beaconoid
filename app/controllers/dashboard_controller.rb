class DashboardController < ApplicationController


  def index
  	@data = CustomerTracking.group_by_store_click
  end
end
