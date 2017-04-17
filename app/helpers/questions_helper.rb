module QuestionsHelper
  def show_live_question(id)
    $liveQ = 1
    id.each do |a|
      $liveqn = a[1]
    end
  end

  def end_live_question
    $liveQ = 0
  end
end
