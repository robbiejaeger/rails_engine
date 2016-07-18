Rails.application.routes.draw do



    namespace :api do
      namespace :v1 do
        resources :merchants, except: [:new, :edit], defaults: {format: :json}
        resources :invoices, except: [:new, :update], defaults: {format: :json}
      end
    end
  end




  # get 'invoices/index', to: 'invoices#index', as: :invoices
