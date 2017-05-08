class DashboardController < ApplicationController


  def index
  	@click_data = CustomerTracking.group_by_store("click", (Time.now-1.month), Time.now)
  	@fetch_data = CustomerTracking.group_by_store("fetch", (Time.now-1.month), Time.now)
  end
end
