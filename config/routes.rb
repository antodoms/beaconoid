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

    get 'report', to: "report#index"
    get 'report/store', to: "report#store"

    resources :stores

    resources :categories

    resources :staffs


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
