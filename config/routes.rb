Rubycious::Application.routes.draw do
  resources :articles do
    put :verify, :on => :member
  end
  resources :sessions
  resources :points

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/tag/:tag', :to => 'articles#tagged', :as => :tagged
  match '/new', :to => 'articles#unverified', :as => :unverified
  match '/about', :to => 'home#about', :as => :about
  match '/profile', :to => 'home#profile', :as => :profile
  match '/rss', :to => 'articles#index', :format => 'rss', :as => :rss

  root :to => "articles#index"
end
