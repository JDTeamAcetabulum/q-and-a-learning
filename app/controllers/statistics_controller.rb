class StatisticsController < ApplicationController
  def index
    @users = User.all
    @questions = Question.all
    @results = Answer.joins(:users)
<<<<<<< HEAD
    @results2 = Users.joins(:answers)
=======
    @userStats ||= []
    @users.each do |user|
      answers = user.answers.where.not(question_id: nil)
      num_correct = answers.where(correct: true).length
      num_incorrect = answers.length - num_correct
      @userStats.push(user.username + "," + num_correct.to_s + "," + num_incorrect.to_s)
    end
>>>>>>> f75e324774c2ec85e2a3416e4f35a30c708c1e17
  end
end
