class StatisticsController < ApplicationController
  def index
    @users = User.all
    @questions = Question.all
    @results = Answer.joins(:users)
  end
end
