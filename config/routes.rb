Rails.application.routes.draw do
  
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    passwords: 'users/passwords',
                                    registrations: 'users/registrations',
                                    unlocks: 'users/unlocks',
                                    invitations: "users/invitations" }
	
	devise_scope :user do
  	match '/users/sign_out' => 'users/sessions#destroy', via: [:get, :delete]
	end
    
  get '/profile' => 'users#profile', as: :profile

  resources :friendships, only: [:create, :destroy] do 
    get 'create' => 'friendships#create', as: "create", on: :collection
    get 'block' => 'friendships#block', as: "block", on: :collection
    get 'destroy' => 'friendships#destroy', as: "destroy", on: :member
  end

  resources :chatrooms do 
    resources :messages, only: [:create, :destroy]
    resource :chatroom_users 

    get 'destroy' => 'chatrooms#destroy', as: "destroy", on: :member
  end

  resources :notifications do 
    post 'read' => 'notifications#read', as: 'read', on: :member
    get 'destroy' => 'notifications#destroy', as: "destroy", on: :member
  end

  resources :users, only: :none do
    resources :notifications, only: [:index]
  end
  
  root to: 'homepage#index'

end


