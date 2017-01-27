class LoginController < ApplicationController
  def login
  end

  def create
    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "login"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
