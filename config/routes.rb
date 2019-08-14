Rails.application.routes.draw do
  root to: 'task_lists#index'
  resources :task_lists
  resources :tasks
end
