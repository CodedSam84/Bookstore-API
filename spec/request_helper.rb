module RequestHelper
  def parse_response_body
    JSON.parse(response.body)
  end
end