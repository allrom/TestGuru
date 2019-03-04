module TestPassagesHelper
  PASS_MARK = 85.0

  def result_percentage
    correct = @test_passage.correct_questions
    total = @test_passage.test.questions.count
    (correct.to_f / total.to_f * 100.0).round(1)
  end

  def pass?
    result_percentage >= PASS_MARK
  end
end
