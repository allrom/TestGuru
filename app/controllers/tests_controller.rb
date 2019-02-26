class TestsController < ApplicationController
  def index
    ## logger.info(self.object_id)
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
  end
end
