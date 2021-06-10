class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @group = current_user.group.find_by(id: params[:id])
    @post = current_user.posts.build(post_params)
    unless @post.save
      render 'error'
    end
  end
  
  def error
  end
  
  def delete
    
  end
  
  private
  
  def post_params
    params.require(:post).permit(:message, :group_id)
  end
  
end
