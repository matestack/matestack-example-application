class MessagesController < ApplicationController
  def create
    messages = Rails.cache.read(Date.today.to_s + "_messages") || []
    messages << {body: permitted_params[:body], from: params[:user] }
    Rails.cache.write(Date.today.to_s + "_messages", messages)
    broadcast
  end

  private

    def permitted_params
      params.require(:message).permit(:body, :user)
    end

    def broadcast
      ActionCable.server.broadcast("matestack_ui_core", {
        message: "new_message_received"
      })
    end
end
