class Contact < MailForm::Base
  ADMIN = ENV['ADMIN_EMAIL']

  attribute :name, validate: true
  attribute :email
  validates :email, :email_format => { message: :malformed }
  attribute :message, validate: true
  attribute :nickname, captcha: true

  # e-mail headers, to be processed by ActionMailer
  def headers
    {
      subject: "Test Guru Feedback Form",
      to: ADMIN,
      from: %("#{name}" <#{email}>)
    }
  end
end
