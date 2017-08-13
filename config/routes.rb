Rails.application.routes.draw do

  resources :posts
  resources :comments, only: [:create, :destroy]
	resources :conversations, only: [:index, :show, :destroy] do
		collection do
	    delete :empty_trash
	  end
		member do
		  post :restore
		  post :reply
		  post :mark_as_read
		end
	end

  resources :messages, only: [:new, :create]

  devise_for :users #:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do	  
    collection do
			get :usersearch
			get :index
			get :google_oauth2
      get :calendar
	  end
    member do     
      get :friends
      get :followers
      get :deactivate
      get :mentionable     
      		
    end
  end
  

  resources :events do
    collection do
      get :calendar
    end
  end
	resources :courses do 
		collection do
			get :index
		end
	end

  authenticated :user do
    root to: 'home#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#front'
  end

 
  if Rails.env.development? and defined?(Localtower)
    mount Localtower::Engine, at: "localtower"
  end
  match :request_tutor, to: redirect("http://www.colgate.edu/centers-and-institutes/center-for-learning-teaching-and-research"), as: :request_tutor, via: :get
  match :usersearch, to: 'users#usersearch', as: :usersearch, via: :get
  match :follow, to: 'follows#create', as: :follow, via: :post #classes are models that can be followed 
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
