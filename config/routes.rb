Rails.application.routes.draw do
  get 'users/show'

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:index, :create, :destroy]
    end
  end

  root 'welcome#index'

  devise_for :users
  resources :users, only: [:show]

  post :incoming, to: 'incoming#create'
end
