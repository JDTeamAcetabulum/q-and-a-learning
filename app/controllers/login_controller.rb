class LoginController < ApplicationController
  def login
  end

  def create
    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      redirect_to("home")
    else
      flash[:danger] = 'Invalid email/password combination'
      render "login"
    end
  end

  def destroy
  end
end
