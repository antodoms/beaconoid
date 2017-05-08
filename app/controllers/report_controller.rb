class ReportController < ApplicationController


  def index
  	@click_data = CustomerTracking.group_by_store_click
  	@fetch_data = CustomerTracking.group_by_store_fetch
  end

  def store
  	if params[:click_page].present?
  		@click_data = CustomerTracking.group_by_store_click(params[:click_page].to_i)
  	else
  		@click_data = CustomerTracking.group_by_store_click
  	end
  	if params[:fetch_page].present?
  		@fetch_data = CustomerTracking.group_by_store_fetch(params[:fetch_page].to_i)
  	else
  		@fetch_data = CustomerTracking.group_by_store_fetch
  	end
  	
  end
end
