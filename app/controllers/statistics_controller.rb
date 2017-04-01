class StatisticsController < ApplicationController
  def index
    @questions = Question.all
    @results = Answer.joins(:users)
  end
end
