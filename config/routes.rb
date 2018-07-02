Rails.application.routes.draw do
  mount StripeEvent::Engine, at: 'webhooks/stripe'

  root 		'static_pages#home'
  get  		'static_pages/home', to: 'static_pages#home'
  get    	'/signup',  to: 'users#new'
  get    	'/login',   to: 'sessions#new'
  post   	'/login',   to: 'sessions#create'
  delete 	'/logout',  to: 'sessions#destroy'
  get  		'/editors/account_info/:id', to: 'editors#account_info', as: :editors_account_info
  post   	'/editors/account_save/:id', to: 'editors#account_save', as: :editors_account_save
  get     '/editors/bank_info/:id', to: 'editors#bank_info', as: :editors_bank_info
  post    '/editors/bank_save/:id', to: 'editors#bank_save', as: :editors_bank_save
  get     '/charges/confirm', to: 'charges#confirm', as: :charges_confirm
  get     '/editors/id_info/:id', to: 'editors#id_info', as: :editors_id_info
  post    '/editors/id_save/:id', to: 'editors#id_save', as: :editors_id_save

  

  resources :charges, :users, :editors, :apps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
