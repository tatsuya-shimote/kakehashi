class PostBroadcastJob < ApplicationJob
  queue_as :default
  #引数には新しいデータが追加された時のものを持ってくる
  def perform(post)
    ActionCable.server.broadcast "chat_channel_#{post.group_id}", message: render_message(post)
  end

  private

  def render_message(post)
    ApplicationController.renderer.render(partial: 'posts/post', locals: {post: post }) #localsにはpartial内で定義した変数をキーに，入れたいものを値にとる
  end
end
