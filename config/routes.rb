LifeTracker::Application.routes.draw do
  root to: "goals#index"

  devise_for :users

  resources :goals do
    resources :tasks
  end

  resources :tasks do
    resources :completions
  end

  resources :completions, only: [:new, :create, :destroy, :index] 

  match "/completions/completed", to: "completions#completed", via: [:post]

  match "/users/:unsubscribe_token/unsubscribe", to: "users#unsubscribe"
  match "/users/average_score", to: "users#average_score"
end
