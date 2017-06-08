class ReportController < ApplicationController

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    if policy(:report).index?
      redirect_to reports_path
    else
      redirect_to dashboard_path
    end
  end

  # method for Report index page
  def index
    authorize :report, :index?

  	@general_data = []
    @general_data << Customer.count
    @general_data << CustomerTracking.where(:action => "fetch").count
    @general_data << CustomerTracking.where(:action => "click").count
    @general_data << Store.count
    @general_data << Category.count
    @general_data << Advertisement.count


  end

  # method for Report Store page
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


  #method for REport Category Page
  def category
    authorize :report, :category?

    if params[:click_page].present?
      @click_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now, params[:click_page].to_i)
    else
      @click_data_category = CustomerTracking.group_by_category("click", (Time.now-1.month), Time.now)
    end
    
    @click_data_count = CustomerTracking.group_by_category_count("click", (Time.now-1.month), Time.now)
    
    @click_data_count = 1 if !@click_data_count.present?
   
  end


  #method for REport Store Sale Page
  def sale
    authorize :report, :store?

    if params[:with_beacon].present?
      @store_with_beacon = CustomerTracking.group_by_sale("with_beacon", (Time.now-1.month), Time.now, params[:with_beacon].to_i)
    else
      @store_with_beacon = CustomerTracking.group_by_sale("with_beacon", (Time.now-1.month), Time.now, params[:with_beacon].to_i)
    end
    if params[:without_beacon].present?
      @store_without_beacon = CustomerTracking.group_by_sale("without_beacon", (Time.now-1.month), Time.now, params[:without_beacon].to_i)
    else
      @store_without_beacon = CustomerTracking.group_by_sale("without_beacon", (Time.now-1.month), Time.now, params[:without_beacon].to_i)
    end
   
  
  end


end
