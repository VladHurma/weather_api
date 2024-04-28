class ApiRequestClient
  require 'net/http'

  def self.request_data(request_url:, request_params:)
    OtelSpanService.do_span(span_name: "to_side_api_request", attributes: { 'api' => request_url }) do
      url = URI(request_url)
      url.query = URI.encode_www_form(request_params)
      JSON(Net::HTTP.get_response(url).body)
    end
  end
end