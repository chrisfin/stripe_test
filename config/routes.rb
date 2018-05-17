Rails.application.routes.draw do
  root 'static_pages#home'
  get  	'static_pages/home', to: 'static_pages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :charges, :users, :editors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
