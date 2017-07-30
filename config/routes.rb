Rails.application.routes.draw do
  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:index, :create, :destroy]
    end
  end

  root 'welcome#index'

  devise_for :users

  post :incoming, to: 'incoming#create'
end
