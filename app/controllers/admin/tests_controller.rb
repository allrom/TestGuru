class Admin::TestsController < Admin::BaseController
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
    test_author

    if @test.save
      redirect_to [:admin, @test], notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test], notice: t('.success')
    else
      render :edit
    end
  end

  def start
    current_user.tests << @test
    redirect_to current_user.test_passage(@test)
  end

  def destroy
    @test.destroy
    redirect_to admin_root_path, notice: t('.success')
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def test_author
    @test.author_id = current_user.id if current_user.admin?
  end
end
