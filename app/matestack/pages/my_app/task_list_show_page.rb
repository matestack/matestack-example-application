class Pages::MyApp::TaskListShowPage < Matestack::Ui::Page
  def response
    components {
      plain "Task Lists"
      @task_lists.each do |task_list|
        div do
          plain task_list.description
          link path: "/task_lists/#{task_list.id}", text: "View tasks"
        end
      end
      br 
      plain "Tasks"
      async rerender_on: "task_created" do
        @task_list.tasks.each do |task|
          div do
            plain task.description
            action do
              button text: "Edit"
            end
            action do
              button text: "Mark as complete"
            end
          end
        end
      end

      div do
        form form_config, :include do
          form_input id: 'description', key: :description, type: :text, placeholder: "Enter task description..."
          form_submit do
            button text: 'Create task'
          end
        end
      end
    }
  end
  
  def form_config
    return {
      for: :task,
      path: :tasks_path,
      method: :post,
      params: {
        task_list_id: @task_list.id
      },
      success: {
        emit: "task_created"
      }
    }
  end
end
