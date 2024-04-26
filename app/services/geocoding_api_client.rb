class GeocodingApiClient

  GEOCODING_API_URL = 'http://api.openweathermap.org/geo/1.0/direct'
  LOCATIONS_LIMIT = 1

  def initialize(location)
    @location = location
  end

  def geo_coordinates
    parse_coordinates(request_geocoding_info)
  end

  private

  def parse_coordinates(geocoding)
    return if geocoding.empty?
    {
      lat: geocoding.first['lat'],
      lon: geocoding.first['lon'],
    }
  end

  def request_geocoding_info
    ApiRequestClient.request_data(
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