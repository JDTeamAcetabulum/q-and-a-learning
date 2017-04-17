module QuestionsHelper
  def show_live_question
    $liveQ = 1
    $liveqn = params[:id]
  end

  def end_live_question
    $liveQ = 0
  end
end
