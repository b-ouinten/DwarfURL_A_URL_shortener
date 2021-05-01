Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#new'
  devise_for :users
  resources :urls
  get '/my_dwarfURLs', to: 'urls#index'

  get '/:id', to: 'urls#show'
end
