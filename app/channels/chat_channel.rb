class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:group_id]}" 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    latest_post = Post.last
  end
end
