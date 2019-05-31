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
    total = test.questions.count
    (correct.to_f / total.to_f * 100.0).round(1)
  end

  def success?
    result_percentage >= PASS_MARK
  end

  def current_question_number
    test.questions.index(current_question) + 1 if current_question
  end

  def expiry_date
    seconds = test.expire_in
    date = self.created_at + seconds
  end

  def expired?
    test.expire_in? && self.expiry_date < DateTime.current
  end

  def to_be_completed_at
    due_hours = self.test.lasting.strftime("%H").to_i
    due_minutes = self.test.lasting.strftime("%M").to_i
    due_seconds = self.test.lasting.strftime("%S").to_i
    interval = self.created_at + due_hours.hour + due_minutes.minute + due_seconds.second
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
