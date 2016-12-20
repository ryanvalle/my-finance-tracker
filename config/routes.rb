Rails.application.routes.draw do
  root 'ui#home'

  scope :api do
  	resources :transactions
  end

	get 'transactions', to: 'ui#transactions', as: 'ui_trans'
	get 'bills', to: 'ui#bills'
	get 'budgets', to: 'ui#budgets'
	get 'analytics', to: 'ui#analytics'
	get 'add', to: 'ui#add'

	post 'auth', to: 'user#auth', as: 'user_auth'
	get 'login', to: 'user#login', as: 'user_login'
	get 'new_user', to: 'user#new', as: 'new_user'
	post 'create', to: 'user#create', as: 'user_create'
end
