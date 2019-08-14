class Pages::MyApp::TaskListPage < Matestack::Ui::Page
  def response
    components {
      plain "Task lists"
      async rerender_on: "task_list_created" do
        @task_lists.each do |task_list|
          div do
            plain task_list.description
            link path: "/task_lists/#{task_list.id}", text: "View task list"
          end
        end
      end

      div do
        form form_config, :include do
          form_input id: 'description', key: :description, type: :text
          form_submit do
            button text: 'Submit me!'
          end
        end
      end
    }
  end
  
  def form_config
    return {
      for: :task_list,
      path: :task_lists_path,
      method: :post,
      success: {
        emit: "task_list_created"
      }
    }
  end
end
