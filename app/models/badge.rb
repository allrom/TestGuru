class Badge < ApplicationRecord
  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users
  belongs_to :rule, class_name: "BadgeRule", optional: true

  validates :title, :image_filename, :rule_id, presence: true
  validates :title, :image_filename, :rule_id, uniqueness: true

  default_scope { order(:id) }
end
