module Admin::AnswersHelper
  def answer_header(_question, answer)
    if answer.new_record?
			t('.header_if_html', body: _question.body)
    else
			t('.header_else_html', body: answer.question.body)
    end
  end
end
