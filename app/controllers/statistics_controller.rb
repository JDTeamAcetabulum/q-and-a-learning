class StatisticsController < ApplicationController
  def index
    @users = User.all
    @questions = Question.all
    @results = Answer.joins(:users)
    @results2 = Users.joins(:answers)
  end
end
