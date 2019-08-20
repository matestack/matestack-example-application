Rails.application.routes.draw do
  root to: "sessions#new"
  resources :sessions, only: [:new, :create]
  resources :messages, only: :create
  get "/chat/:from/:to", to: "chats#new", as: "chat"
  resources :chats, only: :create
end
