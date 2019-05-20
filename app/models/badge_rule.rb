class BadgeRule < ApplicationRecord
  ONE_PASS_CODES = %w[TG-Basic TG-Adv TG-Prof TG-AllBkEnd].freeze

  has_one :badge, foreign_key: "rule_id"

  validates :body, presence: true

  scope :one_pass, -> { where(code: ONE_PASS_CODES).ids }
end
