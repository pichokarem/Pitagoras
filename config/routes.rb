Pitagoras::Application.routes.draw do
  resources :logins, only: [:new, :create]
  resources :leers, only: [:new, :create]
  resources :cargas, only: [:new, :create]
  resources :suscriptors, only: [:new, :create]
  resources :correos, only: [:new, :create]
  resources :vers, only: [:new, :create, :notas]

  resource :leers do
  	get :notas
  end
  get "/paginas/*id", to: 'paginas#show'
  root to: 'logins#new'
end
