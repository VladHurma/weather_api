class WeatherCollectorService
  include TrackTelemetry

  def initialize(location)
    @location = location
  end

  def perform
    coordinates = collect_coordinates
    return if coordinates.values.none?
    collect_weather(coordinates)
  end

  private

  def collect_coordinates
    run_with_telemetry(span_name: 'locations', attributes: { location: @location }) do
      GeocodingApiClient.new(@location).request_coordinates_data
    end
  end

  def collect_weather(coordinates)
    run_with_telemetry(span_name: 'weather') do
      OpenWeatherApiClient.new(coordinates).request_weather_data
    end
  end
end