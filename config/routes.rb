Rails.application.routes.draw do
  resources :photos
  resources :albums
  resources :users
  root "pages#show", page: "home"
  get "/pages/:page" => "pages#show"
  get    "/init",   to: "users#init"
  get    "/reset",   to: "users#reset"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
