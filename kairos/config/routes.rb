require 'api/root'

Rails.application.routes.draw do

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, :path => "auth", :path_name => {
      :sign_in => 'login',
      :sign_out => 'logout'
  }

  #
  # User Area
  #
  resource :gitlab, controller: 'gitlab', only: [] do
    member do
      get :groups
      get '/projects/:id', to: :project
      get '/projects/', to: :projects
      get '/projects/:id/issues', to: :issues_for_project
      get :issues
    end
  end

  #
  # Profile Area
  #
  resource :profiles, only: [:show,] do
    member do
      put :reset_private_token
      put :update_gitlab_private_token
    end
  end

  mount API::Root => '/'

  # Root
  root 'welcome#index'

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
