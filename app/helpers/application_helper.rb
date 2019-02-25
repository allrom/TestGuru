module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(author, repo)
    link_to "* TestGuru * Quiz Simulator Project on #{image_tag('github.png')}GitHub".html_safe,\
            "https://github.com/#{author}/#{repo}", :target => "_blank"
  end
end
