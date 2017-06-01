Rails.application.routes.draw do

 # 	devise_for :users
  	
	#root to: "stores#index"

#	resources :stores

	#########################
    mount ActionCable.server => '/cable'


	devise_for :users

    devise_scope :user do
        authenticated :user do
            root 'dashboard#index', as: :authenticated_root
        end

        unauthenticated do
            root 'devise/sessions#new', as: :unauthenticated_root
        end
    end

	#root to: "stores#index"

    get 'dashboard', to: "dashboard#index"
	
    resources :beacons do
        resources :advertisements
    end

    

    match 'categories/filter', to: "categories#filter", as: :category_filter, via: [:get, :post]
    match 'stores/filter', to: "stores#filter", as: :store_filter, via: [:get, :post]
    match 'advertisements/filter', to: "advertisements#filter", as: :advertisement_filter, via: [:get, :post]
    
    get 'report', to: "report#index"
    get 'report/store', to: "report#store"
    get 'report/category', to: "report#category"
    get 'report/sales', to: "report#sale"

    resources :advertisements
    resources :stores
    resources :categories
    resources :staffs


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
