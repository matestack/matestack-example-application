class Apps::MyApp < Matestack::Ui::App
  def response
    components {
      header class: "header-wrapper"
      main do
        page_content
      end
    }
  end
end
