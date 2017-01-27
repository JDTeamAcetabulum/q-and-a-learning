class LoginController < ApplicationController
  def login
  end

  def create
    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      render "home/home"
    else
      render "register"
    end
  end

  def destroy
  end
end
