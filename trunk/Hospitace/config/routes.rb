Hospitace::Application.routes.draw do


  get "verbal_evaluations/index"

  get "verbal_evaluations/show"

  get "verbal_evaluations/new"

  get "protocols/index"

  get "protocols/show"

  get "protocols/new"

  get "opinion/index"

  get "opinion/show"

  get "opinion/new"

  get "final_reports/index"

  get "final_reports/show"

  get "final_reports/new"

  get "attachments/index"

  get "attachments/show"

  get "attachments/new"

  resources :attachments

  resources :evaluations do
    resources :attachments
    resources :opinions
    resources :verbal_evaluations
    resources :final_reports
    resources :protocols
  end

  root :to => 'home#index'
  
  get "home/index"
  
  resources :courses,:constraints => {:id => /[0-9A-Z]+/i}, :only => [:index,:show,:search] do
    get 'search', :on => :collection
    resources :parallels, :only => [:index, :show]
  end
  
  resources :parallels, :only => [:index, :show]
  
  resources :peoples, :only => [:index, :show]

  resources :observations do 
    resources :evaluations
    #match 'observations/:id/evalvation' => 'observation#evalvation', :as => :observation_evalvation
  end

  resources :users do
    resources :observations
  end
  
  resources :observation_wizard, :only=>[:new,:create,:reset] do
    get 'reset', :on => :member
  end

#  controller 'courses' do
#    match 'courses' => :index
#    match 'courses/:id' => :show, :constraints => {
#      :id => /[0-9A-Z]+/i
#    }
#  end

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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
  
end
