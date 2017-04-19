class StatisticsController < ApplicationController
  def index
    @users = User.all
    @questions = Question.all
    @results = Answer.joins(:users)
    @userStats ||= []
    @users.each do |user|
      answers = user.answers.where.not(question_id: nil)
      num_correct = answers.where(correct: true).length
      num_incorrect = answers.length - num_correct
      @userStats.push(user.username + "," + num_correct.to_s + "," + num_incorrect.to_s)
    end
  end
end
