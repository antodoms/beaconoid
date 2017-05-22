class ReportController < ApplicationController

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    if policy(:report).index?
      redirect_to reports_path
    else
      redirect_to dashboard_path
    end
  end

  def index
    authorize :report, :index?

  	@click_data = CustomerTracking.group_by_store("click", (Time.now-1.month), Time.now)
  	@fetch_data = CustomerTracking.group_by_store("fetch", (Time.now-1.month), Time.now)
    @click_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now)
    @fetch_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now)

  end

  def store
    authorize :report, :store?

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
    
    #binding.pry
    @click_data_count = 1 if !@click_data_count.present?
    @fetch_data_count = 1 if !@fetch_data_count.present?
  end

  def category
    authorize :report, :category?

    if params[:click_page].present?
      @click_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now, params[:click_page].to_i)
    else
      @click_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now)
    end
    # if params[:fetch_page].present?
    #   @fetch_data_category = CustomerTracking.group_by_category("fetch", (Time.now-1.month), Time.now, params[:fetch_page].to_i)
    # else
    #   @fetch_data_category = CustomerTracking.group_by_category("fetch", (Time.now-1.month), Time.now)
    # end
    #binding.pry
    @click_data_count = CustomerTracking.group_by_category_count("click", (Time.now-1.month), Time.now)
    # @fetch_data_count = CustomerTracking.group_by_category_count("fetch", (Time.now-1.month), Time.now)
    
    #binding.pry
    @click_data_count = 1 if !@click_data_count.present?
    # @fetch_data_count = 1 if !@fetch_data_count.present?
  end

end
