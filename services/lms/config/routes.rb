Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    get 'user_courses', to: 'users#user_courses'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :courses do
    resources :lessons
  end

  resources :lessons, only: [] do
    patch :complete, to: "lessons#mark_complete", on: :member
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
