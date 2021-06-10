class GroupsController < ApplicationController
   before_action :require_user_logged_in
   before_action :members?, only: [:members, :exit]
   before_action :members_over?, only: [:join]
   after_action :group_delete, only: [:exit]
   
  
  def index
    @groups = Group.order(id: :desc).page(params[:page]).per(6)
    #@groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      current_user.join(@group)
      redirect_to members_group_path(@group)
    else
      flash.now[:danger] = "全ての項目に入力をしてください。"
      render new_group_path
    end
  end

  def join
    @group = Group.find(params[:id])
    current_user.join(@group)
    redirect_to members_group_path(@group)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
  
  def members
    @group = Group.find(params[:id])
    @post = current_user.posts.build
    @posts = @group.posts
  end
  
  def exit
    @group = Group.find(params[:id])
    current_user.exit(@group)
    redirect_to groups_path
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:limit, :learning, :content)
  end
  
  def group_delete
    @group = Group.find(params[:id])
    if @group.member.count == 0
      @group.destroy
    end
  end
  
  def members?
    unless current_user.members.find_by(group_id: params[:id])
      redirect_to groups_path
    end
  end
  
  def members_over?
      @group = Group.find(params[:id])
      if @group.members.count >= @group.limit
        flash[:warning]="満員のため参加できません。"
        redirect_to group_path(@group)
      end
  end
  
end
