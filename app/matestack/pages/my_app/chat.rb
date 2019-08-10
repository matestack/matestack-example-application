class Pages::MyApp::Chat < Matestack::Ui::Page
  def prepare
  end

  def response
    components {
      div class: "bg-white rounded mx-auto w-1/2 my-10 p-10" do
        span do
          plain "Username: #{@user}"
        end
        async rerender_on: "new_message_received" do
          @messages.each do |message|
            div class: 'w-full block' do
              plain "#{message[:from] || 'anonymous'}: #{message[:body]}"
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
      params: { user: @user },
      success: { emit: "new_input" }
    }
  end
end
