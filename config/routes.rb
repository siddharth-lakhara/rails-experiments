Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "root#index"

  namespace :api do
    namespace :v1 do
      post "/login", to: "users#login"

      post "/users", to: "users#create"
      get "/users/:user_id", to: "users#find_one"
      patch "/users/:user_id", to: "users#update_user"
      delete "/users/:user_id", to: "users#delete_user"

      post "/resource", to: "resource#create"
      get "/resource/all", to: "resource#find_all"
      get "/resource/:resource_id", to: "resource#find_one"
      patch "/resource/:resource_id", to: "resource#update"
      delete "/resource/all", to: "resource#delete_all"
      delete "/resource/:resource_id", to: "resource#delete"
    end
  end

end
