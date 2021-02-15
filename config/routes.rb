Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, except: [:update] do
      put 'update_name', to: 'users#update', on: :member
      put 'update_email', to: 'users#update', on: :member
    end

    resources :orders, except: [:update] do
      put 'update_order_status', to: 'orders#update_order_status', on: :member
      put 'update_payment_status', to: 'orders#update_payment_status', on: :member
    end
  end
end
