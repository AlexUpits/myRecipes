Rails.application.routes.draw do
  get '/home', to: 'pages#home'
  
  root 'pages#home'
  
  resources :recipes do
    member do
      post 'like'
    end
  end
  
end
