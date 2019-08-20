class Pages::MyApp::TaskListShowPage < Matestack::Ui::Page
  def prepare
    @task_lists = TaskList.all
    @task_list = TaskList.find(params[:id])
  end

  def response
    components {
      div class: "mx-auto w-2/3" do
        div class: 'bg-white mt-10 ml-2 p-2' do
          div do
            paragraph class: "mb-5", text: "#{@task_list.description} tasks"
            async rerender_on: "render_tasks" do
              @task_list.tasks.each do |task|
                button class: "btn block p-3 w-full text-left mb-3 hover:bg-gray-100", text: task.description
              end
            end
            form create_task_config(@task_list.id), :include do
              form_input class: "w-full block border p-3 m-1", id: 'description', key: :description, type: :text, placeholder: "Enter task description..."
              form_submit do
                button class: 'btn block bg-green-300 hover:bg-green-400 p-3 mt-3 w-full', text: 'Create task'
              end

              link path: :task_lists_path, class: 'btn block bg-red-300 hover:bg-red-400 p-3 text-center mt-3 w-full', text: 'Back to task lists'
            end
          end
        end
      end
    }
  end

  def create_task_config(task_list_id)
    return {
      for: :task,
      path: :tasks_path,
      method: :post,
      params: {
        task_list_id: task_list_id
      },
      success: {
        emit: "task_created"
      }
    }
  end
end
