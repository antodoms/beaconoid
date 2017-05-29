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

    resources :advertisements

    post 'beacons/index', to: "beacons#filter"
    post 'categories/index', to: "categories#filter"
    post 'stores/index', to: "stores#filter"
    post 'advertisements/index', to: "advertisements#filter"
    
    get 'report', to: "report#index"
    get 'report/store', to: "report#store"
    get 'report/category', to: "report#category"
    get 'report/sales', to: "report#sale"

    resources :stores

    resources :categories

    resources :staffs


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
