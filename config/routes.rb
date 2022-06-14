Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/v1/forecast", to: "api/v1/weather#index"
  get "/api/v1/backgrounds", to: "api/v1/backgrounds#show"
  get "/api/v1/book-search", to: "api/v1/books#index"
  post "/api/v1/users", to: "api/v1/users#create"
  post "/api/v1/sessions", to: "api/v1/sessions#create"
  post "/api/v1/road_trip", to: "api/v1/road_trip#create"
end
