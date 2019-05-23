class BadgeRule < ApplicationRecord

  has_one :badge, foreign_key: "rule_id"

  validates :body, :code, presence: true

  scope :by_code, -> code { where("code = ?", code) }
  scope :by_value, -> value { where("value = ?", value) }
end
