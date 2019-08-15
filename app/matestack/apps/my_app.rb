class Apps::MyApp < Matestack::Ui::App

  def response
    components {
      header do
      end
      main do
        page_content
      end
      footer do
      end
    }
  end

end
