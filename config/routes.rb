# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :movies, only: %i[new create]
  resources :votes, only: %i[create destroy]
end
