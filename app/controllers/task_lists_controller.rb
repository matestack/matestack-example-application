class TaskListsController < ApplicationController
  def index
    @task_lists = TaskList.all
    responder_for(Pages::MyApp::TaskListPage)
  end

  def show
    @task_lists = TaskList.all
    @task_list = TaskList.find(params[:id])
    responder_for(Pages::MyApp::TaskListShowPage)
  end

  def create
    TaskList.create(permitted_params)
  end

  private

    def permitted_params
      params.require(:task_list).permit(:description)
    end
end
