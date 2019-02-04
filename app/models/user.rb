class User < ApplicationRecord
  has_and_belongs_to_many :tests

  def pick_by_level(difficulty_level)
    tests.where(level: difficulty_level)
  end
end
