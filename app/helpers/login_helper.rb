module LoginHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def is_instructor?
    if current_user
      @current_user[:role] == "instructor"
    end
  end

  def check_privilege(controller, action)
    if logged_in?
      if @current_user[:role] != "instructor"
        restricted = {"users" => ["index"], "questions" => ["new", "edit", "short"]}
        not restricted[controller] && restricted[controller].include?(action)
      else
        true
      end
    else
      controller == 'login' || (controller == 'users' && action == 'new')
    end
  end

end
