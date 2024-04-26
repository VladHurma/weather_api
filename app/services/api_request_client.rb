class ApiRequestClient
  require 'net/http'
  def self.request_data(request_url:, request_params:)
    url = URI(request_url)
    url.query = URI.encode_www_form(request_params)
    JSON(Net::HTTP.get_response(url).body)
  end
end