Tweetlinks::Application.routes.draw do

  namespace :api do
    namespace :v1 do
    end
  end

  # A catch-all for backbone
  root :to => 'home#empty'
  match '*path(.:format)' => 'home#empty', :via => :get
end
