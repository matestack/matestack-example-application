class Pages::MyApp::Chat < Matestack::Ui::Page
  def response
    components {
      div class: "bg-white rounded mx-auto w-full md:w-1/2 my-10 p-5" do
        div class: 'text-3xl mb-3' do
          plain 'Chat'
        end
        async rerender_on: "new_message_received" do
          div class: "bg-blue-100 mx-auto rounded p-3" do
            @messages.each do |message|
              div class: 'bg-white rounded p-3 mt-3' do
                if @from.username == message[:from_user]
                  div class: 'text-blue-700' do
                    plain "You"
                  end
                else
                  div class: 'text-black' do
                    plain message[:from_user].titleize
                  end
                end
                div class: 'font-thin' do
                  plain message[:body]
                end
              end
            end
          end
        end
        async rerender_on: "new_input" do
          div class: 'w-full block' do
            form(form_config, :include) do
              form_input class: "border w-full mt-5 rounded p-3", key: "body", type: :text, placeholder: "Type your message here...", init: ""
              form_submit do
                button class: "block bg-gray-300 w-full rounded p-4 mt-5", text: "Send Message"
              end
            end
          end
        end
      end
    }
  end

  def form_config
    return {
      for: :message,
      method: :post,
      path: :messages_path,
      params: { from: @from.id, to: @to.id },
      success: { emit: "new_input" }
    }
  end
end
