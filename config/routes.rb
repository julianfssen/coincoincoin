Rails.application.routes.draw do
  root to: 'derivatives#index'
  resources :derivative_exchanges, param: :coingecko_exchange_id do
    resources :derivatives, only: %i[index show], param: :symbol
  end
  resources :charts, only: %i[show]
  get 'coins', to: 'coins#index'
  get 'coins/:id', to: 'coins#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
