class ChatsController < ApplicationController
  def new
    @user = params[:username]
    @messages = Rails.cache.read(Date.today.to_s + "_messages") || []
    responder_for(Pages::MyApp::Chat)
  end

  def create
    @user = permitted_params[:username].to_s
    render json: { username: @user }
  end

  def permitted_params
    params.require(:chat).permit(:username)
  end
end

