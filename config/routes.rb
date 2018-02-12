Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  root "exams#index"
  devise_for :users
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  resources :users do
    resources :questions
  end
  resources :exams, only: [:index, :show, :create, :update]
  resources :subjects, only: :show
end
