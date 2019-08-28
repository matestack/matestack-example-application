class Apps::Todo < Matestack::Ui::App
  def response
    components {
      header class: "header-wrapper"
      main do
        page_content
      end
      footer do
      end
    }
  end
end
