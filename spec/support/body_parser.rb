module BodyParser
  def body
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include BodyParser, type: :controller
end
