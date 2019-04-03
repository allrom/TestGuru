class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update gist result]

  def show; end

  def result; end

  def gist
    gist_init = GistQuestionService.new(@test_passage.current_question)
    result = gist_init.call

    flash_options = if gist_init.status?
      params = {
        question_id: @test_passage.current_question.id,
        url: result.html_url,
        user_id: current_user.id
      }
      current_user.gists.create(params)
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
