class ChatsController < ApplicationController
  def new
    @from = User.find(params[:from])
    if params[:to] == 'global'
      @to = OpenStruct.new(id: 'global')
      @messages = Rails.cache.read(Date.today.to_s + "_messages_#{@to.id}") || []
    else
      @to = User.find(params[:to])
      @messages = Conversation.find_messages(@from.id, @to.id)
    end

    @messages = @messages&.map do |message|
      message[:from_user] = User.find(message[:from]).username
      message
    end.last(5)

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

