class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable*, :lockable, :timeoutable, :trackable* and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  include Validations

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"
  has_many :gists

  has_many :badge_gears
  has_many :badges, through: :badge_gears

  def pick_by_level(difficulty_level)
    tests.where(level: difficulty_level)
  end

  def test_passage(test)
    test_passages.order(updated_at: :desc).find_by(test_id: test.id)
  end

  def admin?
    self.type == "Admin"
  end
end
