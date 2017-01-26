class LoginController < ApplicationController
  def login
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      render "home/home"
    else
      render "login/login"
    end
  end

  def destroy
  end
end
