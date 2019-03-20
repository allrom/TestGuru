class Admin::QuestionsController < Admin::BaseController
  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show; end

  def new
    ## logger.debug(self.object_id)
    @question = Question.new
  end

  def edit; end

  def create
    @question = @test.questions.new(new_question_params)
    if @question.save
      redirect_to admin_question_path(@question), notice: "New Question created..."
    else
      render :new
    end
  end

  def update
    if @question.update(new_question_params)
      redirect_to admin_question_path(@question), notice: "Question updated..."
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(:id => @question.test_id),
                notice: "Question deleted..."
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Question not found...', status: 404
  end

  def new_question_params
    params.require(:question).permit(:body)
  end
end
