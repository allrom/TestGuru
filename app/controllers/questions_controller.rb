class QuestionsController < ApplicationController
  before_action :find_test, only: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = Question.where(:test_id => @test.id)

    render inline: '<p>* Question(s) *</p>
                    <p><%= @questions.pluck(:body).join("<br/>").html_safe %></p>'
  end

  def show
    @question = Question.find(params[:id])

    render inline: '<p>Requested Question is: <%= @question.body %></p>'
  end

  def new
    @test_id = params[:test_id]
  end

  def create
    new_question = Question.create(new_question_params)

    render plain: new_question.inspect
  end

  def destroy
    question = Question.destroy(params[:id])
    redirect_to root_path, notice: "Question '#{question.id}' deleted..."
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question not found...'
  end

  def new_question_params
    params.require(:question).permit(:body, :test_id)
  end
end
