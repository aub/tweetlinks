require 'sidekiq/web'

Tweetlinks::Application.routes.draw do

  # TODO: make it so not everybody can see this
  mount Sidekiq::Web => '/sidekiq'

  match '/auth/twitter/callback', to: 'sessions#create', via: :get

  mount JasmineRails::Engine => '/specs' unless Rails.env.production?

  namespace :api do
    namespace :v1 do
      resources :tweets, only: :index
    end
  end

  # A catch-all for backbone
  root :to => 'home#empty'
  match '*path(.:format)' => 'home#empty', :via => :get
end
