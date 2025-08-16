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
      post "/users", to: "users#create"
      get "/users/:user_id", to: "users#findOne"
      patch "/users/:user_id", to: "users#updateUser"
      delete "/users/:user_id", to: "users#deleteUser"

      post "/resource/:owner_id", to: "resource#create"
      get "/resource/:owner_id/all", to: "resource#findAll"
      get "/resource/:owner_id/:resource_id", to: "resource#findOne"
      get "/resource/:resource_id", to: "resource#findOneResource"
      patch "/resource/:owner_id/:resource_id", to: "resource#update"
      delete "/resource/:owner_id/:resource_id", to: "resource#deleteOne"
      delete "/resource/:owner_id", to: "resource#deleteAll"
    end
  end

end
