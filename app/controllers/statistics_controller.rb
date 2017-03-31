class StatisticsController < ApplicationController
  def index
    @questions = Question.all
    @results = Answer.joins(:users)
    @users = User.all
    @uresults = User.joins(:answers)
  end
end
