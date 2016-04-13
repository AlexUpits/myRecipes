Rails.application.routes.draw do
  get '/home', to: 'pages#home'
  
  root 'pages#home'
  
  resources :recipes
  
end
