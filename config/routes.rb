Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "show", to: "gps#show"
      post "gps", to: "gps#create"
    end
  end
end
