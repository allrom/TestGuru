class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update gist result]

  def show; end

  def result
    badge_list
  end

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

  def badge_list
    if @test_passage.passed
      gear_init = BadgeGearService.new(current_user, @test_passage)
      result = gear_init.call
    end

    if result
      flash.now[:notice] = t('.success', codes: result.join(' * '))
    else
      flash.now[:alert] = t('.failure')
    end
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
