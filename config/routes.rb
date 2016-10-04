Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
      end
      namespace :customers do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
      end
      namespace :items do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
      end
      namespace :invoices do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
      end
      namespace :invoice_items do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
      end
      namespace :transactions do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
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
