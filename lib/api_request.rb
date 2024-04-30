require 'net/http'

module ApiRequest
  def perform_request(request_url:, request_params:)
    url = URI(request_url)
    url.query = URI.encode_www_form(request_params)
    JSON(Net::HTTP.get_response(url).body)
  end
end