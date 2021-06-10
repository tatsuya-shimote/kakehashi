class PasswordChangesController < ApplicationController
  before_action :require_user_logged_in
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_changes][:email])
    if @user == current_user
      redirect_to edit_password_change_path(current_user)
    else
      flash.now[:danger] = "メールアドレスが違います。"
      render 'new'
    end
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(password_params)                     
      flash[:success] = "パスワードを変更しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
    
end
