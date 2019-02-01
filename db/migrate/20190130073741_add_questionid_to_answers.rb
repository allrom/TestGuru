class AddQuestionidToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column(:answers, :question_id, :integer)
    change_column_null(:answers, :question_id, false)
  end
end
