# Methods added to this helper will be avail to all templates  in the app
module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(author, repo)
    link_to "* TestGuru * Quizz Simulator Project on #{image_tag('github.png')}GitHub".html_safe,\
            "https://github.com/#{author}/#{repo}", :target => "_blank"
  end

  def flash_message
    flash.map do |type, message|
      content_tag :div, message, class: "flash #{type}" if flash[type]
    end.join.html_safe
  end
end
