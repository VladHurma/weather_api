class OpenWeatherApiClient
  OPEN_WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather'

  def initialize(location)
    @location = location
  end

  def weather_data
    request_weather_info(location_coordinates)
  end

  private

  def request_weather_info(location_coordinates)
    return unless location_coordinates

    ApiRequestClient.request_data(
      request_url: OPEN_WEATHER_API_URL,
      request_params: build_request_params(location_coordinates),
    )
  end

  def build_request_params(location_coordinates)
    {
      lat: location_coordinates[:lat],
      lon: location_coordinates[:lon],
      appid: ENV['WEATHER_API_KEY'],
    }
  end

  def location_coordinates
    GeocodingApiClient.new(@location).geo_coordinates
  end
end