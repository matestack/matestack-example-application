class Todo::TasksController < ApplicationController

  def create
    Task.create(permitted_params.merge("done" => false, "task_list_id" => params[:task_list_id]))
  end

  def destroy
    Task.find(params[:id]).destroy
  end

  def update
    Task.find(params[:id]).update(permitted_params.to_h)
  end

  private

    def permitted_params
      params.require(:task).permit(:description, :done)
    end
end
