module LoginHelper

  # Logs in the given user.
  def log_in(user)
    login[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: login[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    login.delete(:user_id)
    @current_user = nil
  end
end
