module Admin::AnswersHelper
  def answer_header(_question, answer)
    if answer.new_record?
      "Create New * #{_question.body} * Answer"
    else
      "Edit * #{answer.question.body} * Answer"
    end
  end
end
