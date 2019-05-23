class BadgesUser < ApplicationRecord

  belongs_to :user
  belongs_to :badge

  scope :scope_by_id, -> id { where(badge_id: id) if id.present? }

  def self.badge_count(badge_id)
    scope_by_id(badge_id).count
  end
end
