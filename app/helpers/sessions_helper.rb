module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
  
  #ユーザー詳細ページの編集機能を表示するかしないかに利用
  def current_user?
    current_user == User.find_by(id: params[:id])
  end
  
  def group_member?
    current_user.members.find_by(group_id: params[:id])
  end
  
   # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
    
end
