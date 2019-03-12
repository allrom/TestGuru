module User::Validations

  extend ActiveSupport::Concern

  included do
    validates :identity, :email, presence: true

    validates :email, uniqueness: true
    validates :email, :email_format => { :message => "format is invalid" }

    ## validates :password, presence: true, if: Proc.new { |u| u.password_digest.blank? }
    ## validates :password, confirmation: true
  end
end
