class Todo::TaskListsController < ApplicationController
  def index
    responder_for(Pages::Todo::TaskListPage)
  end

  def show
    responder_for(Pages::Todo::TaskListShowPage)
  end

  def create
    TaskList.create(permitted_params)
  end

  private

    def permitted_params
      params.require(:task_list).permit(:description)
    end
end
