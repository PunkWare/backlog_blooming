module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def signed_in_user
    unless signed_in?
      # used to store location of the URI requested by the user.
      # permit the forwarding whien the user has signed in
      store_location
      
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
      # the line above is equivalent to :
      #flash[:notice] = "Please sign in."
      #redirect_to signin_path unless signed_in?
    end
  end
  
  def is_admin?
    current_user.admin?
  end
    
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
end
