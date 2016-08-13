Rails.application.routes.draw do
  root 'welcome#index'
  get     'user_login'   => 'usersessions#new'
  post    'user_login'   => 'usersessions#create'
  delete  'user_logout'  => 'usersessions#destroy'

  resources :users do
    get :export, on: :collection
  end

  resources :products

  namespace :admin do
    get     'login'   => 'sessions#new'
    post    'login'   => 'sessions#create'
    delete  'logout'  => 'sessions#destroy'
    resources :admins
    root 'manage#index'
  end

  namespace :api do
    resources :users, only: [:index], defaults: {format: :json} do
      get :get_info, on: :collection, defaults: {format: :json}
      get :get_qrcode, on: :collection, defaults: {format: :json}
      get :get_invite_code, on: :collection, defaults: {format: :json}
      get :set_superior, on: :collection, defaults: {format: :json}
      patch :update_profile, on: :collection, defaults: {format: :json}
      get :get_balance, on: :collection, defaults: {format: :json}
      get :commissions, on: :collection, defaults: {format: :json}
      get :subordinates, on: :collection, defaults: {format: :json}
      get :wx_get_jsapi_ticket, on: :collection, defaults: {format: :json}
    end
    resources :feedbacks, only: :create
    resources :leaders, only: [:index, :create], defaults: {format: :json}
    get 'get_serial_number' => 'codes#index'
  end
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
