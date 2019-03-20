module Admin::QuestionsHelper
  def question_header(_test, question)
    if question.new_record?
      "Create New * #{_test.title} * Question"
    else
      "Edit * #{question.test.title} * Question"
    end
  end
end
