class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :signup_hello, only: :index
  before_action :find_test, only: :start

  def index
    @tests = Test.all
  end

  def start
    current_user.tests << @test
    redirect_to current_user.test_passage(@test)
  end

  def signup_hello
    if unset_signup_hello? && current_user.sign_in_count == 1
      flash.now[:warning] = t('.greet') + ", #{current_user.identity_name} !"
      session[:welcome] = true
    end
  end

  def unset_signup_hello?
    !session[:welcome]
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
