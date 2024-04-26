require "test_helper"

class WeatherApiControllerTest < ActionDispatch::IntegrationTest
  test "should get weather" do
    get weather_api_weather_url
    assert_response :success
  end
end
