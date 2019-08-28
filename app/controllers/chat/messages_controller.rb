class Chat::MessagesController < ApplicationController
  def create
    messages = Message.where(from: params[:from], to: params[:to])
    Message.create(
      from: params[:from],
      to:   params[:to],
      body: permitted_params[:body]
    )

    broadcast
  end

  private

    def permitted_params
      params.require(:message).permit(:body)
    end

    def broadcast
      ActionCable.server.broadcast("matestack_ui_core", {
        message: "new_message_received"
      })
    end
end
