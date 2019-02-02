class User < ApplicationRecord
  def pick_by_level(difficulty_level)
    answered_qs_ids = Answer.select('question_id').where(user_id:  self.id)
    taken_tsts_ids = Question.select('test_id').where(id: answered_qs_ids)
    Test.where(id: taken_tsts_ids, level: difficulty_level)
  end
end
