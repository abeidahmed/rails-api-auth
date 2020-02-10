class ApplicationController < ActionController::API
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    # Check for session token, returns nil if user_id is not present or if 
    # user is not logged in
    return nil unless session[:user_id]
    # Return user if token is valid
    @current_user || User.find_by(id: session[:user_id])
  end

  def log_out!
    session.delete(:user_id)
    @current_user = nil
  end
end
