class MessagesController < ApplicationController
  def create
    from = params[:from]
    to = params[:to]
    if to == 'global'
      cache_key = Date.today.to_s + "_messages_#{to}"
    else
      cache_key = Date.today.to_s + "_messages_#{to}_#{from}"
    end

    messages = Rails.cache.read(cache_key) || []
    messages << {body: permitted_params[:body], from: from, to: to, created_at: DateTime.now.to_s}
    Rails.cache.write(cache_key, messages)
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
