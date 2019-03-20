module User::Validations

  extend ActiveSupport::Concern

  included do
    validates :identity_name, :email, presence: true

    validates :email, uniqueness: true
    validates :email, :email_format => { :message => "format is invalid" }
  end
end
