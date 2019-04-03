class GistQuestionService
  TOKEN = ENV['GITHUB_GIST_TOKEN']

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: TOKEN)
  end

  def call
    @client.create_gist(gist_params)
  end

  def status?
    @client.last_response.status == 201
  end

  private

  def gist_params
    {
      description: I18n.t('.services.gist_params.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
