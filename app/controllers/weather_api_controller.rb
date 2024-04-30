class WeatherApiController < ApplicationController
  before_action :build_params, only: [:weather]

  def weather
    raw_weather_data = WeatherCollectorService.new(@params[:location]).perform
    if raw_weather_data
      @weather = WeatherPresenter.new(weather: raw_weather_data, temp_scale: @params[:temp_scale])
      render template: 'weather_api/weather', formats: :json
    else
      handle_errors(["Current location does not exist"])
    end
  end

  private

  def build_params
    check_params

    @params = {
      location: params[:location],
      temp_scale: params[:scale],
    }
  end

  def check_params
    error_msgs = []
    error_msgs << "Location is empty or missed, please, provide them." if params[:location].blank?
    if params[:scale]
      unless WeatherPresenter::TEMP_SCALES.include?(params[:scale])
        error_msgs << "Please, provide correct temperature scale. Possible ones: #{WeatherPresenter::TEMP_SCALES.join(', ')}."
      end
    end
    handle_errors(error_msgs) unless error_msgs.blank?
  end

  def handle_errors(messages)
    render json: { error_message: "Error: #{messages.join('; ')}" }, status: :unprocessable_entity
  end
end
