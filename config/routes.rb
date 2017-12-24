Rails.application.routes.draw do
  root 'welcome#index'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :welcome, only: [:index]

  resources :users, except: [:index]

  resources :houses, except: [:index] do
    resources :notes, only: [:new, :create]
  end

  resources :notes, except: [:index, :new, :create]
end
