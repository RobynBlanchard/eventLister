Rails.application.routes.draw do
  get 'homepage/index'

  root 'homepage#index'
  resources :artists
  get 'listings/index'
  #get '/index' => 'homepage#index'
  #resources :url_uploads


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
