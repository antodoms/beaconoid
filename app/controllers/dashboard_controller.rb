class DashboardController < ApplicationController


  def index
  	@click_data = CustomerTracking.group_by_store_click
  	@fetch_data = CustomerTracking.group_by_store_fetch
  end
end
