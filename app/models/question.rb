class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy
  belongs_to :test

  validates :body, presence: true

  validate :validate_total_answers, on: :update

  private

  def validate_total_answers
    errors.add(:answers) unless answers.size < 5
  end
end
