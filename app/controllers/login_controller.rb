class LoginController < ApplicationController
  def login
    if view_context.logged_in?
      redirect_to home_path
    end
  end

  def create
    @user = User.find_by(username: params[:login][:username])
    if @user && @user.authenticate(params[:login][:password])
      view_context.log_in @user
      redirect_to home_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render "login"
    end
  end

  def destroy
    view_context.log_out
    redirect_to root_url
  end
end
