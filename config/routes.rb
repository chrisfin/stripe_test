Rails.application.routes.draw do
  resources :charges
  resources :users
  resources :editors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
