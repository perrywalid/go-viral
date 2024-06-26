Rails.application.routes.draw do
  post 'posts/create', to: 'posts#create'
  devise_for :users, defaults: { format: :json }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :user_statistics, only: [:index, :show, :create, :update, :destroy]
      end
      
    end
end