class TestPassage < ApplicationRecord
  PASS_MARK = 85.0

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: "Question", optional: true

  ## before_validation :before_validation_set_first_question, on: :create
  ## before_update     :before_update_set_next_question, unless: :completed?

  before_save :before_save_set_next_question, on: %i[create, update]

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    answer_ids ||= []
    self.correct_questions += 1 if correct_answer?(answer_ids)

    ## self.current_question = next_question
    save!
  end

  def result_percentage
    correct = self.correct_questions
    total = self.test.questions.count
    (correct.to_f / total.to_f * 100.0).round(1)
  end

  def pass?
    result_percentage >= PASS_MARK
  end

  def current_question_number
    self.test.questions.pluck(:id).index(current_question.id) + 1
  end

  private

  ## def before_validation_set_first_question
  ##   self.current_question = test.questions.first if test.present?
  ## end

  ## def before_update_set_next_question
  ##   self.current_question = next_question
  ## end

  def before_save_set_next_question
    self.current_question = self.new_record? ? test.questions.first : next_question
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
