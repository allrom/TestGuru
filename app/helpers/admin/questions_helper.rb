module Admin::QuestionsHelper
  def question_header(_test, question)
    if question.new_record?
      t('.header_if_html', title: _test.title)
    else
      t('.header_else_html', title: question.test.title)
    end
  end
end
