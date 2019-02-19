class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions

    render inline: '<p>* Question(s) *</p>
                    <p><%= @questions.pluck(:body).join("<br/>").html_safe %></p>'
  end

  def show
    @question = Question.find(params[:id])

    render inline: '<p>Requested Question is: <%= @question.body %></p>'
  end

  def new; end

  def create
    new_question = @test.questions.new(new_question_params)
    if new_question.save
      redirect_to question_path(new_question), :notice => "New Question created..."
    else
      render action: new
    end
  end

  def destroy
    question = Question.destroy(params[:id])
    redirect_to root_path, :notice => "Question '#{question.id}' deleted..."
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
