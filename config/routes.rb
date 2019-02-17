# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  unauthenticated do
    root to: 'welcome_page#index'
  end

  authenticated do
    root to: 'dashboard#index'
  end

  resources :dashboard, only: :index
  resources :welcome_page, only: :index
  resources :users, only: %i[show update]
  resources :profile_pictures, only: %i[index] do
    post :like, on: :member
    post :dislike, on: :member
    get :most_rated, on: :collection
  end
end
