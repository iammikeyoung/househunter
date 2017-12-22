Rails.application.routes.draw do
  root 'welcome#index'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :welcome, only: [:index]

  resources :users, except: [:index] do
    resources :houses, only: [:new, :create] #or should I set this with '@current_user?'
  end

  resources :houses, except: [:new, :create] do
    resources :notes, only: [:new, :create]
  end

  resources :notes, except: [:new, :create]
end
