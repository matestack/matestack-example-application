class Apps::MyApp < Matestack::Ui::App

  def response
    components {
      header do
        heading size: 1, text: "Tasks"
      end
      main do
        page_content
      end
    }
  end

end
