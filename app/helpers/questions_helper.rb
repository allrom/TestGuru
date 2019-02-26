module QuestionsHelper
  def question_header(_test, question)
    if question.new_record?
      p "Create New * #{_test.title} * Question"
    else
      p "Edit * #{question.test.title} * Question"
    end
  end
end
