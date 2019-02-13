class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  validate :validate_answers_count, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_count
    errors.add(:question) unless Answer.where(question_id: self.question_id).count < 4
  end
end
