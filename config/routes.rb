Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: %i[create index show update destroy] 
          post "/login", to: "users#login"
          get "/auto_login", to: "users#auto_login"
          resources :facts
        resources :books
      end
    end
  end
