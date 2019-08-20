class SessionsController < ApplicationController
  def new
    responder_for(Pages::MyApp::Sessions::New)
  end

  def create
    user = User.new(id: permitted_params[:id], username: permitted_params[:username])

    if user.save
      render json: {}, status: :ok
    end
  end

  def permitted_params
    params.require(:user).permit(:id, :username)
  end
end
