class TasksController < ApplicationController
  def create
    Task.create(permitted_params.merge("task_list_id" => params[:task_list_id]))
  end

  def destroy
    Task.find(params[:task_id]).destroy
  end

  private

    def permitted_params
      params.require(:task).permit(:description)
    end
end
