module Admin::TestsHelper
  def test_header(test)
    if test.new_record?
      t('.header_if_html')
    else
      t('.header_else_html', title: test.title)
    end
  end

  def test_timing(test)
    if test.expire_in?
      t('.test_interval')
    else
      t('.test_interval_else')
    end
  end
end
