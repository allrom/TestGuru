class TestsMailer < ApplicationMailer

  def completed_test(test_passage)
		@sent_at = I18n.l(Date.today, format: :long, locale: I18n.locale.to_sym)
    @user = test_passage.user
    @test = test_passage.test

    mail to: @user.email
  end
end
