Rails.application.routes.draw do
  root 'welcome#index'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :welcome, only: [:index]
  resources :users do
    resources :houses, except: [:index]
  end

  resources :houses, only: [:show] do
    resources :notes
  end
  resources :notes, except: [:new, :create]

end
