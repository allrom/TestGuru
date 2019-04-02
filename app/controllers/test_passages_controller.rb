class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update gist result]

  def show; end

  def result; end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    flash_options = if result.is_a?(Sawyer::Resource)
      params = {
        question_id: @test_passage.current_question.id,
        url: result.html_url,
        email: current_user.email
      }
      gist_to_store = Gist.new(params)
      gist_to_store.accept!
      { notice: t('.success', gist_url: result.html_url) }
    else
      { alert: t('.failure') }
    end
    redirect_to @test_passage, flash_options
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
