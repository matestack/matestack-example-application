class Pages::MyApp::Sessions::New < Matestack::Ui::Page
  def prepare
    @user = User.new(id: Cuid.generate, username: '')
  end

  def response
    components {
      div class: "bg-white rounded mx-auto w-full md:w-1/2 my-10 p-10" do
        div class: 'w-full block' do
          form(form_config, :include) do
            label text: "Username"
            form_input class: "border w-full mt-3 rounded p-3 hidden", key: :id, type: :text
            form_input class: "border w-full mt-3 rounded p-3", key: :username, type: :text, placeholder: "Enter a username here..."
            form_submit do
              button class: "block bg-gray-300 w-full rounded p-4 mt-5", text: "Register"
            end
          end
        end
      end
    }
  end

  def form_config
    return {
      for: @user,
      method: :post,
      path: :sessions_path,
      success: {
        transition: {
          path: :chat_path,
          params: {
            from: @user.id,
            to: 'global'
          }
        }
      }
    }
  end
end
