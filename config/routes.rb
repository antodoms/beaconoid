Rails.application.routes.draw do

 # 	devise_for :users
  	
	#root to: "stores#index"

#	resources :stores

	#########################

	devise_for :users
	root to: "stores#index"

    get 'dashboard', to: "dashboard#index"
	
    resources :beacons do
        resources :advertisements
    end

    resources :advertisements

    

    resources :stores

    resources :categories

    get "/app/views/advertisement/list", to: "advertisement#list", as: "adList"

    get 'advertisement/adList'
    get 'advertisement/new'
    post 'advertisement/create'
    patch 'advertisement/update'
    get 'advertisement/list'
    get 'advertisement/show'
    get 'advertisement/edit'
    get 'advertisement/delete'
    get 'advertisement/update'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
