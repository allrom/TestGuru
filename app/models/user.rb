class User < ApplicationRecord
  ## has_and_belongs_to_many :tests
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  validates :identity, :email, presence: true

  def pick_by_level(difficulty_level)
    tests.where(level: difficulty_level)
  end

  def test_passage(test)
    test_passages.order(updated_at: :desc).find_by(test_id: test.id)
  end
end
