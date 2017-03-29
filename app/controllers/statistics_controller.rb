class StatisticsController < ApplicationController
  def index
    @questions = Question.all
    @results = Answer.joins(:users)
    p @results
  end
end
