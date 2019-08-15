class Pages::MyApp::TaskListPage < Matestack::Ui::Page
  def response
    components {
      div class: "mx-auto w-2/3 flex" do
        div class: "flex-1 w-1/3 bg-white mt-10 p-3 ml-2" do
          plain "Task lists"
          hr
          async rerender_on: "task_list_created" do
            @task_lists.each do |task_list|
              div do
                link path: "/task_lists/#{task_list.id}", class: 'btn bg-white-300 hover:bg-gray-100 p-3 mt-3 block w-full', text: "#{task_list.description}"
              end
            end
          end

          div do
            form create_task_list_config, :include do
              form_input class: 'border p-3 block w-full mt-3 mb-3', id: 'description', key: :description, type: :text, placeholder: "Task list name..."
              form_submit do
                button class: 'btn bg-green-300 hover:bg-green-400 p-3 w-full', text: 'Create Task list'
              end
            end
          end
        end
        # div class: 'flex-2 w-2/3 bg-white mt-10 ml-2 p-2' do
        #   async rerender_on: "task_list_created" do
        #     @task_lists.each do |task_list|
        #       div rerender_on: "task_created", show_on: "show_tasks_#{task_list.id}" do
        #         plain "#{task_list.description} tasks"
        #         task_list.reload.tasks.each do |task|
        #           plain task
        #         end
        #         div do
        #           form create_task_config(task_list.id), :include do
        #             form_input class: "w-full block border p-3 m-1", id: 'description', key: :description, type: :text, placeholder: "Enter task description..."
        #             form_submit do
        #               button class: 'btn bg-green-300 hover:bg-green-400 p-3 w-full', text: 'Create task'
        #             end
        #           end
        #         end
        #       end
        #     end
        #   end
        # end
      end
    }
  end

  def create_task_list_config
    return {
      for: :task_list,
      path: :task_lists_path,
      method: :post,
      success: {
        emit: "task_list_created"
      }
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
