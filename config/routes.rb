Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  authenticated :user do
    root 'urls#new'
  end
  root 'offline/urls#new'

  namespace :offline do
    resources :urls
    get '/my_dwarfURLs', to: 'urls#index'
    get '/:id', to: 'urls#show'
  end
  
  resources :urls
  get '/my_dwarfURLs', to: 'urls#index'
  get '/:id', to: 'urls#show'
end
