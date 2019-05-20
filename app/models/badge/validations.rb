module Badge::Validations
  extend ActiveSupport::Concern

  included do
    validates :program, :image_filename, :rule_id, presence: true
    validates :program, :image_filename, :rule_id, uniqueness: true
  end
end
