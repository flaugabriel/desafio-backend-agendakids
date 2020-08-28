# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: %i[edit update index] do
    member do
      get 'messages'
    end
  end

  resources :messages do
    collection do
      get 'sent'
    end
  end

  get '/archived' => 'messages#archived', as: 'archived'
  patch '/archive' => 'messages#archive', as: 'archive', defaults: { format: 'js' }
  patch '/archive_multiple' => 'messages#archive_multiple', as: 'archive_multiple', defaults: { format: 'js' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users
      resources :users, only: %i[edit update index] do
        member do
          get 'messages'
        end
      end

      devise_scope :user do
        root to: 'devise/sessions#new'
        get 'profile', to: 'users#edit'
      end

      resources :messages do
        collection do
          get 'sent'
        end
      end
      get '/archived' => 'messages#archived'
      patch 'messages/:id/archive' => 'messages#archive'
      patch '/archive_multiple' => 'messages#archive_multiple'
    end
  end
end
