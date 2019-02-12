class Question < ApplicationRecord
  has_many :answers
  belongs_to :test

  validates :body, presence: true

  validate :validate_answers_count, on: :update

  private

  def validate_answers_count
    errors.add(:answers) unless answers.size.between?(1, 4)
  end
end
