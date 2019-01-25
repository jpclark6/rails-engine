Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/', to: 'customers#index'
        get '/find', to: 'find_customers#show'
        get '/find_all', to: 'find_customers#index'
        get '/random', to: 'random#show'
        get '/:id', to: 'customers#show'
      end
      namespace :merchants do
        get '/most_revenue', to: 'merchants_revenue#index'
        get '/most_items', to: 'merchants_items#index'
        get '/revenue', to: 'merchants_revenue_by_date#show'
        get '/:id/revenue', to: 'merchants_revenue#show'
        get '/:id/favorite_customer', to: 'merchant_favorite_customer#show'
        get '/:id/items', to: 'merchants_items_list#index'
        get '/:id/invoices', to: 'merchants_invoices_list#index'
      end
    end
  end
end
