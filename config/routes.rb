Rails.application.routes.draw do

  devise_for :residents, controllers: {
    sessions: 'public/sessions',
    registrations: 'admin/resident/registrations'
  }

  root 'homes#about'
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }

  namespace :admin do
    resources :posts
    resources :residents, only: [:index, :show, :edit, :update] do
      resources :households, only: [:new, :create, :edit, :update]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
