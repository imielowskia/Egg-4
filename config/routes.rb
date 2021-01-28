Rails.application.routes.draw do
  resources :egzams
  resources :questions
  devise_for :users
  get 'start/index'

  get 'import/lista'
  post 'import/import'

  root to: "start#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
