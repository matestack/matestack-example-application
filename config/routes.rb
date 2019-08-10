Rails.application.routes.draw do
  root to: "my_app#my_example_page"
  get "/chat/:username", to: "chats#new", as: "new_chat"
  resources :messages
  resources :chats, only: :create
  scope :my_app do
    get 'my_example_page', to: 'my_app#my_example_page'
  end
end
