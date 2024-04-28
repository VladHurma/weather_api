class WeatherApiController < ApplicationController
  before_action :build_params, only: [:weather]

  def weather
    raw_weather_data = OpenWeatherApiClient.new(@params[:location]).weather_data
    if raw_weather_data
      @weather = prepare_presenter(raw_weather_data)
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

  def prepare_presenter(raw_weather_data)
    OtelSpanService.do_span(span_name: "present_weather", attributes: { 'scale' => @params[:temp_scale] }) do
      WeatherPresenter.new(raw_weather_data, temp_scale: @params[:temp_scale])
    end
  end
end
