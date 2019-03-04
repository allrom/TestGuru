module AnswersHelper
  def answer_header(_question, answer)
    if answer.new_record?
      p "Create New * #{_question.body} * Answer"
    else
      p "Edit * #{answer.question.body} * Answer"
    end
  end
end
