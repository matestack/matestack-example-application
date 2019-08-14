class Task < Base
  attr_accessor :id, :description, :task_list_id

  def initialize(attributes)
    @id = nil
    @description = attributes[:description]
    @task_list_id = attributes[:task_list_id]
  end

  def save
    task = super
    task_list = TaskList.find(self.task_list_id)
    task_list.tasks.class == Array ? task_list.tasks << self : task_list.tasks = []
    task_list.save
    task
  end
end
