class ChatsController < ApplicationController
  def new
    @from = User.find(params[:from]).username
    @to = params[:to]
    if @to == 'global'
      @messages = Rails.cache.read(Date.today.to_s + "_messages_#{@to}") || []
    else
      @messages = Rails.cache.read(Date.today.to_s + "_messages_#{@from}_#{@to}") || []
    end
    @messages = @messages.last(5)
    responder_for(Pages::MyApp::Chat)
  end

  def creates
    @user = permitted_params[:username].to_s
    render json: { username: @user }
  end

  def permitted_params
    params.require(:chat).permit(:username)
  end
end

