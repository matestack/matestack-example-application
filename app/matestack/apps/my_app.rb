class Apps::MyApp < App::Cell::App

  def response
    components {
      header do
        heading size: 1, text: "My App"
      end
      main do
        page_content
      end
    }
  end

end
