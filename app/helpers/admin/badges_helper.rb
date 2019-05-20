module Admin::BadgesHelper
  def badge_header(badge)
    if badge.new_record?
			t('.header_if_html')
    else
			t('.header_else_html', program: badge.program)
    end
  end
end
