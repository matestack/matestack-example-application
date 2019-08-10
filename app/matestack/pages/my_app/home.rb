class Pages::MyApp::Home < Matestack::Ui::Page
  def prepare
    @user = OpenStruct.new(username: "test")
  end

  def response
    components {
      div class: "bg-white rounded mx-auto w-1/2 my-10 p-10" do
        div class: 'w-full block' do
          async hide_on: "my_event" do
            form(form_config, :include) do
              label text: "Username"
              form_input class: "border w-full mt-3 rounded p-3", key: :username, type: :text, placeholder: "Type your message here..."
              form_submit do
                button class: "block bg-gray-300 w-full rounded p-4 mt-5", text: "Register"
              end
            end
          end
          async show_on: "my_event" do
            # action path: new_chat_path(username: "test") do
              button class: "block bg-gray-300 w-full rounded p-4 mt-5", text: "Join chat as {{event.data.username}}"
            # end
          end
        end
      end
    }
  end

  def form_config
    return {
      for: @user,
      method: :post,
      path: :chats_path,
      success: {
        # emit: "my_event"
        transition: { path: :new_chat_path, params: { username: @user.username } }
      }
    }
  end
end
