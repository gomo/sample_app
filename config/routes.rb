no_trailing_slash = proc{|request|
  uri = request.env["REQUEST_URI"]
  !!uri && !uri.end_with?("/")
}

Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help', constraints: no_trailing_slash
  get  '/about',   to: 'static_pages#about', constraints: no_trailing_slash
  get  '/contact', to: 'static_pages#contact', constraints: no_trailing_slash
  get  '/signup',  to: 'users#new', constraints: no_trailing_slash
  get    '/login',   to: 'sessions#new', constraints: no_trailing_slash
  post   '/login',   to: 'sessions#create', constraints: no_trailing_slash
  delete '/logout',  to: 'sessions#destroy', constraints: no_trailing_slash
  resources :users, constraints: no_trailing_slash
end