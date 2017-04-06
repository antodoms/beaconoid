Rails.application.routes.draw do

 # 	devise_for :users
  	
	#root to: "stores#index"

#	resources :stores

	#########################

	devise_for :users
	root to: "beacon#list"
	resources :beacon

	get 'beacon/list'
   	get 'beacon/new'
    post 'beacon/create'
    patch 'beacon/update'
    get 'beacon/list'
    get 'beacon/show'
    get 'beacon/edit'
    get 'beacon/delete'
    get 'beacon/update'

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
