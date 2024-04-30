class GeocodingApiClient
  include ApiRequest

  GEOCODING_API_URL = 'http://api.openweathermap.org/geo/1.0/direct'.freeze
  LOCATIONS_LIMIT = 1.freeze

  def initialize(location)
    @location = location
  end

  def request_coordinates_data
    parse_coordinates(request_geocoding)
  end

  private

  def parse_coordinates(geocoding)
    {
      lat: geocoding.first&.fetch('lat'),
      lon: geocoding.first&.fetch('lon'),
    }
  end

  def request_geocoding
    perform_request(
        request_url: GEOCODING_API_URL,
        request_params: build_request_params,
      )
  end

  def build_request_params
    {
      q: @location,
      limit: LOCATIONS_LIMIT,
      appid: ENV['GEOCODING_API_KEY'],
    }
  end
end