Rails.application.routes.draw do
  devise_for :users
  root "exams#index"
  resources :exams, only: [:index, :create]
  resources :users do
    resources :questions
  end
  resources :exams, only: [:index, :show, :create, :update]
end
