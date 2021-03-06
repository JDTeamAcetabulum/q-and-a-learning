class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if not @user.is_instructor?
      # List of this user's questions and answers
      @answers = @user.answers.where.not(question_id: nil)
      @questions = @answers.map{ |answer| answer.question }

      @num_correct = @answers.where(correct: true).length
      @num_incorrect = @answers.length - @num_correct
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user[:role] = "student"
    if @user.save
      flash[:success] = "New user created!"
      view_context.log_in @user
      redirect_to home_path
    else
      if @user.password.length < 6
        flash[:error] = "Password must be at least 6 characters"
      elsif !User.where(username: @user.username).empty?
        flash[:error] = "Username \"#{@user.username}\" already taken"
      else
        flash[:error] = "Couldn't create user"
      end
      redirect_to register_path
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv}
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation, :role)
    end
end
