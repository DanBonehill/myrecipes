Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: "pages#home"
  
  resources :recipes do
    resources :comments, only: [:create]
<<<<<<< HEAD
    member do 
      post 'like'
    end
=======
>>>>>>> 81f328a649516b9e183065ad0c1533d05eaebb93
  end
    
  resources :issues
  
  get "/signup", to: "chefs#new"
  
  resources :chefs, except: [:new]
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  resources :ingredients, except: [:destroy]
  
end
