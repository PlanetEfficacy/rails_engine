Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
        get ":id/customers_with_pending_invoices", to: "customers#index"
        get ":id/items", to: "items#index"
        get ":id/invoices", to: "invoices#index"
      end
      namespace :customers do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
      end
      namespace :items do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
      end
      namespace :invoices do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
        get ':id/transactions', to: 'transactions#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/items', to: 'items#index'
        get ':id/customer', to: 'customer#show'
        get ':id/merchant', to: 'merchant#show'
      end
      namespace :invoice_items do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
      end
      namespace :transactions do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'random', to: 'random#show'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end


end
