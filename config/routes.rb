Pitagoras::Application.routes.draw do
  resources :logins, only: [:new, :create]
  resources :leers, only: [:new, :create, :notas]
  resources :cargas, only: [:new, :create]
  resources :suscriptors, only: [:new, :create]
  resources :correos, only: [:new, :create]
  resources :vers, only: [:new, :create, :notas]
  get "/paginas/*id", to: 'paginas#show'
  root to: 'logins#new'
end
