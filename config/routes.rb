Rails.application.routes.draw do
  root 'events#index'
  resources :uploads
  get 'events/index'
  #get '/index' => 'homepage#index'
  #resources :url_uploads


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
