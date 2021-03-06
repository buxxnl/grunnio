SiliconGroningen::Application.routes.draw do
  root to: 'home#show'
  # devise_for :accounts, skip: :registrations,
  #                       controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_for :accounts, controllers: { omniauth_callbacks: 'omniauth_callbacks', :registrations => "registrations" }
  match '/account/profile/new' => 'people#new', :as => 'account_new_profile'

  localized do
    resources :companies
    resources :people
    resources :initiatives
  end
  # scope(:path_names => { :new => "nieuw", :edit => "aanpassen" }) do
  #   resources :companies, :path => "bedrijven"
  #   resources :mensen
  #   resources :initiatieven
  # end

  namespace :admin do
    root to: 'dashboard#show'
    resources :accounts
    resources :jobs
    resources :people do
      # resource :card
      resources :companies
      resources :initiatives
    end
    resources :initiatives do
      # resource :card
      # resource :location
      resources :people
    end
    resources :companies do
      # resource :card
      # resource :location
      resources :jobs
      resources :people
    end
  end


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
