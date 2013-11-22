Drive::Application.routes.draw do

  get "favourites/index"

  resources :blog_comments


  resources :comment_logbooks

  resources :user_blogs

  resources :comments

  resources :favourites

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions", :passwords => "passwords"}

  devise_scope :user do
  authenticated :user do
    root :to => 'home#index'
  end
  unauthenticated :user do
    root :to => 'devise/registrations#new'
  end
end

  devise_for :admins

  resources :users,  :only => [:index,:destroy]


  post "dynamic_models/:id" => "carprofiles#dynamic_models"

  match '/users/:id/toggled_status', :to => "users#toggled_status"

  match '/pages/:id' => 'pages#show'

  namespace :admin do 
    match '/dashboard' => "dashboard#index", :as => :root
    resources :pages
    resources :blogs
    resources :seos
    resources :car_makes
    resources :credits
    resources :car_models
    resources :logbook_categories
    resources :egift_categories
    resources :egifts
    resources :engines
    resources :body_indices
    resources :credit_packages
  end

  resources :credits do
    collection do
      get :earn_credits
      post :get_credits
    end
  end
  resources :admincontacts
  resources :logbooks
  resources :carprofiles do
    collection do 
      post :like_car
      get :like_count
    end
  end 
  resources :carprofile_photos

 
  root :to => "devise/registrations#new"

  match '/contact' => 'home#contact'
  match 'search' => 'home#search'

#:controllers => {:registrations => "registrations"}
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'


end
