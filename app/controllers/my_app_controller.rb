class MyAppController < ApplicationController
  def my_example_page
    responder_for(Pages::MyApp::Home)
  end
end
