class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /popup_question
  def popup_question
    respond_to do |format|
      format.html
      format.js
    end
  end

  def get_popup_html
    render :partial => 'questions/popup_question'
  end

  def check_live_question
    if $liveQ == 1
      @question = Question.find($liveqn)
      @results = Answer.joins(:users).group("answers.id").count
      # Answer given by the student, if present
      answers = Answer.joins(:users)
        .where("question_id = '#{@question.id.to_s}'")
        .where("user_id = '#{current_user[:id].to_s}'")
      @answered = !answers.blank?
      @answer = @answered ? answers[0] : nil
      if @answered || @current_user[:role] == "instructor"
        render :nothing => true
      else
        render :partial => 'questions/show'
      end
    else
      render :nothing => true
    end
  end

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @results = Answer.joins(:users).group("answers.id").count
    # Answer given by the student, if present
    answers = Answer.joins(:users)
      .where("question_id = '#{@question.id.to_s}'")
      .where("user_id = '#{current_user[:id].to_s}'")
    @answered = !answers.blank?
    @answer = @answered ? answers[0] : nil
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.build_correct_answer
    setup_answers
  end

  # GET /questions/1/edit
  def edit
  end

  def short
    @question = Question.new
    @question.build_correct_answer
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    answers_param = params[:question][:answers_attributes]
    answers_param.each_with_index do |(key,value), index|
      if defined? @question.answers[index]
        @question.answers[index]
          .update_attributes(:content => value[:content][0], :correct => value[:correct])
      else
        @question.answers.build(:content => value[:content][0], :correct => value[:correct])
      end
    end
    @question.published_at = Time.current if publishing?

    respond_to do |format|
      if @question.save
        @question.published_at = Time.current if publishing?
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.published_at = Time.current if publishing?
    respond_to do |format|
      if @question.update(question_params)
        @question.correct_answer.update(question_params[:correct_answer_attributes])
        update_answers
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # This method is used when a student answers a question and submits the form.
  def submit_question
    current_user.answers << Answer.find_by_id(params[:answer])
    respond_to do |format|
        format.html { redirect_to questions_url, notice: 'Questions successfully answered.' }
    end
  end

  def export
    @questions = Question.all
    respond_to do |format|
      format.html
    end
  end

  def build_csv
    lecture_ids = params[:question][:lecture_ids]
    topic_ids = params[:question][:topic_ids]
    question_ids = params[:question][:question_ids]

    Lecture.where(id: lecture_ids).each do |l|
      l.questions.each do |q|
        question_ids << q.id
      end
    end

    Topic.where(id: topic_ids).each do |t|
      t.question.each do |q|
        question_ids << q.id
      end
    end

    questions = Question.where(id: question_ids)

    respond_to do |format|
      format.csv { send_data questions.to_csv, filename: "questions-#{Date.today}.csv" }
    end
  end

  def import
    respond_to do |format|
      format.html
    end
  end

  def import_csv
    begin
      Question.import(params[:file], current_user)
      redirect_to questions_path, notice: 'Upload successful'
    rescue
      redirect_to questions_path, notice: 'Upload failed (bad CSV)'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id, :all_topics, :all_lectures,
                                       :content,
                                       correct_answer_attributes: [:correct, :content],
                                       answers_attributes: [:correct, :content, :id])
    end

    def setup_answers
      3.times do
        @question.answers.build
      end
    end

    def update_answers
      keep = []
      params[:question][:answers_attributes].each do |key, val|
        keep.push(val['id'])
        Answer.find_by_id(val['id']).update_attributes(:content => val[:content][0])
      end
      @question.answers.each do |answer|
        if !answer.correct? && !keep.include?(answer[:id].to_s)
          answer.destroy
        end
      end
    end

    def publishing?
      params[:commit] == "Publish"
    end
end
