class User < ApplicationRecord
  has_and_belongs_to_many :tests
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  validates :identity, :email, presence: true

  scope :person_to_test, -> user { where(:identity => user.identity) }

  def self.scope_by_user_level(user, level)
    Test.test_by_level(level)
        .joins(:users)
        .merge(person_to_test(user))
  end

  def pick_by_level(difficulty_level)
    self.class.scope_by_user_level(self, difficulty_level)
  end
end
