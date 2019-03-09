Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, only: [:index,:show,:new,:create,:edit,:update],param: :user_id  do 
    member do 
      resources :pets, only:[:index,:new,:create,:edit,:update,:destroy]
    end
  end
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  
  
end
