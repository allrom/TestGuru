class Badge < ApplicationRecord
  include Validations

  has_many :badge_gears, dependent: :destroy
  has_many :users, through: :badge_gears
  belongs_to :rule, class_name: "BadgeRule", optional: true

  default_scope { order(:id) }
end
