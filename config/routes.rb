Rails.application.routes.draw do

  devise_for :residents, controllers: {
    sessions: 'public/sessions',
    registrations: 'admin/resident/registrations'
  }

  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get '/events/new', to: 'admin_events#new', as: 'new_events'
    get '/events', to: 'admin_events#index', as: 'events'
    get '/events/:id/edit', to: 'admin_events#edit', as: 'edit_event'
    post '/events/new', to: 'admin_events#create', as: 'event'
    patch '/events/:id', to: 'admin_events#update'
    delete '/events/:id', to: 'admin_events#destroy'
    resources :posts
    resources :messages, only: [:index, :create, :destroy]
    resources :residents, only: [:index, :show, :edit, :update] do
      resources :photos, only: [:index, :new, :create, :destroy]
      resources :households, only: [:new, :create, :edit, :update]
    end
  end

  scope module: :admin do
    resources :admins, only: [:index]
    resources :meals, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  scope module: :public do
    root 'homes#about'
    get '/mypage', to: 'residents#show'
    get '/edit', to: 'residents#edit'
    get '/confirm', to: 'residents#confirm'
    patch '/edit', to: 'residents#update'
    resources :messages, only: [:index]
    resources :myevents, only: [:new, :create, :edit, :update, :destroy]
    resources :posts, only: [:index, :show] do
      resource :bookmarks, only: [:create, :destroy]
    end
    get '/bookmarks', to: 'bookmarks#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
