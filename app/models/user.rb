class User < ApplicationRecord
  has_and_belongs_to_many :tests
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  def pick_by_level(difficulty_level)
    tests.where(level: difficulty_level)
  end
end
