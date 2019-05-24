class Pages::MyApp::MyExamplePage < Page::Cell::Page

  def response
    components {
      div do
        plain "hello world!"
        5.times do
          br
          plain 'Hurray!'
        end
      end
    }
  end

end
