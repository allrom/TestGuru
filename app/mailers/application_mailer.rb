class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <gurus@testguru.edu>}
  layout 'mailer'
end
