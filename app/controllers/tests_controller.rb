class TestsController < ApplicationController
  def index
    ## logger.info(self.object_id)
    @tests = Test.all

    render inline: '<p>* All of Tests *</p>
                    <p><%= @tests.pluck(:id, :title).map { |t| t.join(". ") }
                      .join("<br/>")
                      .html_safe %></p>'
  end
end
