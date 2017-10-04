Rails.application.routes.draw do
  root 'static_pages#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/users', to: 'users#index',   trailing_slash: true
  resources :users


  # get '*path', controller: 'application', action: 'render_404'
end