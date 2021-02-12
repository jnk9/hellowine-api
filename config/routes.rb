Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, except: [:update]
    put '/users/:id/update_name', to: 'users#update'
    put '/users/:id/update_email', to: 'users#update'
  end
end
