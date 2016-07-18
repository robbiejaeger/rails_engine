Rails.application.routes.draw do



    namespace :api do
      namespace :v1 do
        resources :invoices, except: [:new, :update], defaults: {format: :json}
      end
    end
  end




  # get 'invoices/index', to: 'invoices#index', as: :invoices
