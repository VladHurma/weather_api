Rails.application.routes.draw do
  get 'weather_api/weather', to: 'weather_api#weather'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
