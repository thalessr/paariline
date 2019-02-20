# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path: 'users'
  devise_for :admins, path: 'user_admin'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  unauthenticated :user do
    root to: 'welcome_page#index'
  end

  authenticated :user do
    root to: 'dashboard#index'
  end

  resources :dashboard, only: :index
  resources :welcome_page, only: :index
  resources :chat_rooms, only: :index
  resources :chat_messages, only: :index
  resources :activities, only: :index
  resources :users, only: %i[show update]
  resources :profile_pictures, only: %i[index] do
    post :like, on: :member
    post :dislike, on: :member
    get  :most_rated, on: :collection
  end
end
