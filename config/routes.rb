Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :users, only: [:create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
    end
  end
end