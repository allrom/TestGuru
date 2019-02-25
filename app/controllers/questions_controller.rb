class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create new]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index; end

  def show
    ## logger.debug(self.object_id)
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = @test.questions.new(new_question_params)
    if @question.save
      redirect_to question_path(@question), :notice => "New Question created..."
    else
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(new_question_params)
      redirect_to question_path(@question), :notice => "Question updated..."
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.answers.any?
      redirect_to question_path(@question),
                  :notice => "Can't delete, Question has related answers..."
    else
      @question.destroy
      redirect_to test_questions_path(:test_id => @question.test_id),
                  :notice => "Question deleted..."
    end
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question not found...', status: 404
  end

  def new_question_params
    params.require(:question).permit(:body)
  end
end
