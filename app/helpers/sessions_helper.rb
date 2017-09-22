module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if @current_user.nil? then
      @current_user = User.find_by(id: session[:user_id]) || false
    end
    @current_user
  end
  
  def logged_in?
    !!current_user
  end
end
