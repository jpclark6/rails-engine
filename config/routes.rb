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
    end
  end
end
