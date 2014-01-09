Drive::Application.routes.draw do

  resources :contactadmins


  resources :messages do
    collection do
      get :trash_messages
      get :sent_messages
      put :move_all_to_trash_recipient
      put :delete_all_by_sender
    end
    
    member do
     post :trash
     post :destroy_recipient
     post :destroy_sender
     get :reply
    end
  end


 resources :friendships do
  member do
     post :accept
     post :decline
     post :delete
     post :cancel
  end
 end

 resources :shared do
    collection do
      get :search
      get :all_car
    end
  end

  resources :blog_comments

  resources :notifications do 
    collection do
      get :noti_delete
    end
  end
  
  resources :comment_logs
  match "logbooks/:id/user_logbook"  => 'favourites#user_logbook'

  match "user_blogs/:id/user_blog"  => 'favourites#user_blog'

  match "carprofiles/:id/mycarprofile"  => 'favourites#mycarprofile'
 
  resources :comment_logbooks

  resources :user_blogs do
    collection do 
      post :like_blog
      get :like_count
      get :all_blogs
    end
  end

  resources :comments
  resources :new_cars
  resources :favourites do
    collection do
      get :deletefav
    end
  end

   resources :egifts ,:only => [:index] do
     resources :send_gifts
     collection do
      get :my_gifts
      get :anonymous
      get :personal
      get :egift_notifications
     end
   end

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

  resources :users,  :only => [:index,:destroy,:show,:subscribe_profile,:block_user,:unblock_user,:blocked_users,:change_status,:edit,:update,:new,:create] do
  collection    do
      post :subscribe_profile
      get  :user_emails
      post :block_user
      post :unblock_user
      get  :blocked_users
      post :change_status
    end
   member do
      get :friend_request
      get :user_friends
      get :user_cars
      get :user_gifts
   end
  end
  

 
  match '/users/:id/toggled_status', :to => "users#toggled_status"

  match "/carprofiles/update_model", :to => "carprofiles#update_model"

  match "/carprofiles/update_body", :to => "carprofiles#update_body"

  match "/logbooks/updatemodel", :to => "logbooks#updatemodel"

  match "/logbooks/updatebody", :to => "logbooks#updatebody"

  match "/logbooks/all_logbook", :to => "logbooks#all_logbook"

  match '/pages/:id' => 'pages#show'

  match 'logbooksearch' => 'logbooks#logbooksearch'

  match 'blogsearch' => 'user_blogs#blogsearch'

  match "myfriend"  => 'logbooks#myfriend'

  match "/logbooksearch_home", :to => "home#logbooksearch_home"

  match "myfriend_blog"  => 'user_blogs#myfriend_blog'

  match "/carprofiles/comment_destroy", :to => "carprofiles#comment_destroy"

  namespace :admin do 
    match '/dashboard' => "dashboard#index", :as => :root
    match '/admin_mailer' => 'admin_mailers#admin_mailer'
    resources :pages
    resources :blogs
    resources :seos
    resources :car_makes
    resources :credits
    resources :car_models
    resources :logbook_categories
    resources :egift_categories
    resources :egifts
    resources :engines do 
      collection do
        delete 'destroy_multiple'
      end
    end
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
  resources :logbooks do 
    collection do 
      post :like_logbook
      get :like_count
    end
  end
  resources :carprofiles do
    collection do 
      post :like_car
      get :like_count
      post :subscribe_car
      post :spotlight
      post :post_comment
      get :guest_user
    end
  end 
  resources :carprofile_photos

 resources :logbook_categories do 
    get :search, :on => :collection
  end

  resources :blogs do 
    get :search_blog, :on => :collection
  end
 
  root :to => "devise/registrations#new"
   match 'subscribe_count' => 'home#subscribe_count'

  match 'subscar_count' =>'carprofiles#subscar_count'

  
  match '/contact' => 'home#contact'
  match 'search' => 'home#search'
  match 'searchpeople' => 'home#searchpeople'
  match 'keywordsearch' => 'home#keywordsearch'
  match 'topcar' => 'home#topcar'
  match 'paginate_top_car' => 'home#paginate_top_car'

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
