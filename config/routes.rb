Rails.application.routes.draw do
  # Routes for the User:
  
  root to: "users#index"

  # User-related routes
  get "/users", to: "users#index", as: "users"
  get "/users/:username", to: "users#show", as: :user_profile
  get "/users/:username/likes", to: "likes#index", as: :user_likes
  get "/users/:username/feed", to: "photos#feed", as: :user_feed


  #discovery_route?
  #feedlink

  get "/users/:username/discover", to: "photos#discover", as: :user_discover
  get "/users/:username/liked_photos", to: "likes#liked_photos", as: :user_liked_photos

  # Follow Request
  resources :follow_requests, only: [:create, :destroy] do
    member do
      patch :accept
      delete :reject
    end
  end

  # Routes for the Photo resource
  resources :photos, only: [:index, :create, :show, :update, :destroy] do
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:create, :index, :show, :destroy], shallow: true
  end




  devise_for :users


  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
