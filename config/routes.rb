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




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
