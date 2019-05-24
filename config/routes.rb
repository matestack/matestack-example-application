Rails.application.routes.draw do

  scope :my_app do
    get 'my_example_page', to: 'my_app#my_example_page'
  end

end
