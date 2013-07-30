LifeTracker::Application.routes.draw do
  root to: "goals#index"

  devise_for :users

  resources :goals do
    resources :tasks
  end

end
