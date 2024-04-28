class WeatherPresenter
  KELVIN_ZERO = 273.freeze
  FAHRENHEIT_ZERO = 32.freeze
  FAHRENHEIT_COEFFICIENT = 1.8.freeze
  TEMP_SCALES = %w[celsius fahrenheit kelvin].freeze

  def initialize(weather:, temp_scale: 'celsius')
    @weather = weather
    @temp_scale = temp_scale
  end

  def location_name
    "#{@weather['name']}, #{@weather['sys']['country']}"
  end

  def general_weather
    [
      @weather["weather"][0]["main"],
      @weather["weather"][0]["description"],
    ].join(': ')
  end

  def temperature
    self.send(@temp_scale, @weather['main']['temp'])
  end

  def feels_like
    self.send(@temp_scale, @weather['main']['feels_like'])
  end

  def humidity
    "#{@weather['main']['humidity']}%"
  end

  def wind_speed
    "#{@weather['wind']['speed']} M/S"
  end

  private

  def celsius(temp)
    celsius_degrees = (temp - KELVIN_ZERO).round(2)
    "#{celsius_degrees} °C"
  end

  def fahrenheit(temp)
    fahrenheit_degrees = (FAHRENHEIT_COEFFICIENT*(temp - KELVIN_ZERO) + FAHRENHEIT_ZERO).round(2)
    "#{fahrenheit_degrees} °F"
  end

  def kelvin(temp)
    "#{temp} °K"
  end
end