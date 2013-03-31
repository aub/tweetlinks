Tweetlinks::Application.routes.draw do

  mount JasmineRails::Engine => '/specs' unless Rails.env.production?

  namespace :api do
    namespace :v1 do
    end
  end

  # A catch-all for backbone
  root :to => 'home#empty'
  match '*path(.:format)' => 'home#empty', :via => :get
end
