class ReportController < ApplicationController


  def index
  	@click_data = CustomerTracking.group_by_store("click", (Time.now-1.month), Time.now)
  	@fetch_data = CustomerTracking.group_by_store("fetch", (Time.now-1.month), Time.now)
  end

  def store
  	if params[:click_page].present?
  		@click_data = CustomerTracking.group_by_store("click", (Time.now-1.month), Time.now, params[:click_page].to_i)
  	else
  		@click_data = CustomerTracking.group_by_store("click", (Time.now-1.month), Time.now)
  	end
  	if params[:fetch_page].present?
  		@fetch_data = CustomerTracking.group_by_store("fetch", (Time.now-1.month), Time.now, params[:fetch_page].to_i)
  	else
  		@fetch_data = CustomerTracking.group_by_store("fetch", (Time.now-1.month), Time.now)
  	end
    #binding.pry
  	@click_data_count = CustomerTracking.group_by_store_count("click", (Time.now-1.month), Time.now)
    @fetch_data_count = CustomerTracking.group_by_store_count("fetch", (Time.now-1.month), Time.now)
  end
end
