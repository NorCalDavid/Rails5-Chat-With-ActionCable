Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
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
  get '/public-profile' => 'users#public_profile', as: :public_profile

  resources :friendships, only: [:create, :destroy] do 
    get 'create' => 'friendships#create', as: "create", on: :collection
    post 'block' => 'friendships#block', as: "block", on: :collection
    post 'destroy' => 'friendships#destroy', as: "destroy", on: :collection
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


