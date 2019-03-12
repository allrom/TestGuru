class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test, only: %i[show edit update destroy start]

  def index
    ## logger.info(self.object_id)
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect to @test
    else
      render :new, notice: "New Test created..."
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit, notice: "Test updated..."
    end
  end

  def start
    current_user.tests << @test
    redirect_to current_user.test_passage(@test)
  end

  def destroy
    @test.destroy
    redirect_to tests_path, notice: "Test deleted..."
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
