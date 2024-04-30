class OpenWeatherApiClient
  include ApiRequest

  OPEN_WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather'.freeze

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def request_weather_data
    perform_request(
      request_url: OPEN_WEATHER_API_URL,
      request_params: build_request_params,
    )
  end

  private

  def build_request_params
    {
      lat: @coordinates[:lat],
      lon: @coordinates[:lon],
      appid: ENV['WEATHER_API_KEY'],
    }
  end
end