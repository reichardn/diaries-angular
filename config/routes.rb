Rails.application.routes.draw do
  
  resources :diaries do 
    resources :entries, only: [:create]
  end

  resources :entries
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :user, only: [] do 
    resources :diaries, only: [:index]
  end

  root 'welcome#home'

  post 'diaries/:id/submit', to: 'diaries#submit', as: 'submit'

 
end
