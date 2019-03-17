module Admin::TestsHelper
  def test_header(test)
    if test.new_record?
      p "Create New Test"
    else
      p "Edit * #{test.title} * Test"
    end
  end
end
