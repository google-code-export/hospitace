Hospitace::Application.routes.draw do



  get "test/index"

  mount Ckeditor::Engine => '/ckeditor'

  get "home/index"
  get "contact" => 'contact#contact'
  
  get "observed" => 'my_observations#observed', :as=> :my_observations_observed
  get "manage" => 'my_observations#manage', :as=> :my_observations_manage
  get "observing" => 'my_observations#observing', :as=> :my_observations_observing
  
  resources :users
  resources :notes

  match 'observations/:id/date' => 'observations#date', :via => [:get, :post], :as => :observation_date
  
  resources :observations, :except=> [:edit] do
    match "courses" => 'courses#select', :via => [:get, :post], :on=>:collection, :as=>:observation_courses
    #match "date" => 'observations#date', :via => [:get, :post], :on=>:member,:as => :date
    resources :notes
    resources :observers, :only=> [:index, :new, :create, :destroy]
  end


  match "peoples/select" => 'peoples#select', :via => [:get, :post], :as=>:peoples_select
  resources :peoples, :only => [:index, :show]
  #resources :courses, :only => [:index, :show]

  match "courses/:course_id/parallels/select" => 'parallels#select', :via => [:get, :post], :as=>:course_parallels_select
  resources :courses, :only => [:index,:show] do
    match "courses", :via => [:get, :post], :on=>:collection
    resources :parallels, :only => [:index, :show, :search]
  end
  
  resources :user_sessions
  
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
