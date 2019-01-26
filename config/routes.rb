Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/', to: 'customers#index'
        get '/find', to: 'find_customers#show'
        get '/find_all', to: 'find_customers#index'
        get '/random', to: 'random#show'
        get '/:id', to: 'customers#show'
        get '/:id/invoices', to: 'customer_invoices#index'
        get '/:id/transactions', to: 'customer_transactions#index'
      end
      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/most_revenue', to: 'merchants_revenue#index'
        get '/most_items', to: 'merchants_items#index'
        get '/revenue', to: 'merchants_revenue_by_date#show'
        get '/:id', to: 'merchants#show'
        get '/:id/revenue', to: 'merchants_revenue#show'
        get '/:id/favorite_customer', to: 'merchant_favorite_customer#show'
        get '/:id/items', to: 'merchants_items_list#index'
        get '/:id/invoices', to: 'merchants_invoices_list#index'
      end
      namespace :invoices do
        get '/', to: 'invoices#index'
        get '/:id', to: 'invoices#show'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end
      namespace :invoice_items do
        get '/', to: 'invoice_items#index'
        get '/find', to: 'find_invoice_items#show'
        get '/find_all', to: 'find_invoice_items#index'
        get '/random', to: 'random#show'
        get '/:id', to: 'invoice_items#show'
      end
      namespace :items do
        get '/', to: 'items#index'
        get '/:id', to: 'items#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get 'best_day', to: 'best_day#show'
      end
      namespace :transactions do
        get '/', to: 'transactions#index'
        get '/:id', to: 'transactions#show'
        get '/:id/invoice', to: 'invoice#show'
      end
    end
  end
end
