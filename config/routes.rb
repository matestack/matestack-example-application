Rails.application.routes.draw do

  namespace :todo do
    get '/', to: 'task_lists#index'
    resources :task_lists
    resources :tasks
  end

  namespace :chat do
    get '/', to: "sessions#new"
    resources :sessions, only: [:new, :create]
    resources :messages, only: :create
    get "/:from/:to", to: "chats#new", as: "chat"
    resources :chats, only: :create
  end

end
