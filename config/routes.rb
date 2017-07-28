Rails.application.routes.draw do

  resources :topics do
    resources :bookmarks
  end

  root 'welcome#index'

  devise_for :users

  post :incoming, to: 'incoming#create'
end
