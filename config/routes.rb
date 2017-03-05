Rails.application.routes.draw do
  resources :photos
  resources :albums
  resources :users
  get    '/init',   to: 'users#init'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
