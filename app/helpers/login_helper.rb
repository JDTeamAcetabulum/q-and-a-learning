module LoginHelper

  # Logs in the given user.
  def log_in(user)
    login[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: login[:user_id])
  end
end
