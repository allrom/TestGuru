class Admin::AnswersController < Admin::BaseController
  before_action :find_answer, only: %i[show edit update destroy]
  before_action :find_question, only: %i[new create]

  # GET /answers/1
  def show; end

  # GET /answers/new
  def new
    @answer = @question.answers.new
  end

  # GET /answers/1/edit
  def edit; end

  # POST /answers
  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to admin_answer_path(@answer), notice: 'Answer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      redirect_to [:admin, @answer], notice: 'Answer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    redirect_to [:admin, @answer.question], notice: 'Answer was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end
