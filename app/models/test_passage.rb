class TestPassage < ApplicationRecord
  PASS_MARK = 85.0

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: "Question", optional: true

  before_save :before_save_set_next_question, on: %i[create, update]

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    answer_ids ||= []
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def result_percentage
    correct = self.correct_questions
    total = self.test.questions.count
    (correct.to_f / total.to_f * 100.0).round(1)
  end

  def success?
    result_percentage >= PASS_MARK
  end

  def current_question_number
    self.test.questions.index(current_question) + 1 if current_question
  end

  def expiry_date
    seconds = self.test.expire_in
    date = self.created_at + seconds
  end

  def expired?
    self.test.expire_in? && self.expiry_date < DateTime.current
  end

  scope :passed_list, -> { where(passed: true) }

  private

  def before_save_set_next_question
    self.current_question = self.new_record? ? test.questions.first : next_question
    self.passed = true if self.success?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
