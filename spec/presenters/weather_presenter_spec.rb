require 'rails_helper'

RSpec.describe WeatherPresenter do
  let(:weather_json) do
    {
      name: 'Test name',
      sys: { country: 'Test country' },
      weather: [
        { main: 'Test main weather', description: 'description'},
      ],
      main: { temp: 273, feels_like: 273, humidity: 0 },
      wind: { speed: 0 },
    }.deep_stringify_keys
  end
  let(:presenter_sample) { described_class.new(weather: weather_json) }

  it 'collects name' do
    expect(presenter_sample.location_name).to eq('Test name, Test country')
  end

  it 'collects general weather' do
    expect(presenter_sample.general_weather).to eq('Test main weather: description')
  end

  it 'collects humidity' do
    expect(presenter_sample.humidity).to eq('0%')
  end

  it 'collects wind speed' do
    expect(presenter_sample.wind_speed).to eq('0 M/S')
  end

  describe '#temperature scale' do
    it 'return celsius' do
      presenter = described_class.new(weather: weather_json, temp_scale: 'celsius')
      expect(presenter.temperature).to eq('0 °C')
      expect(presenter.feels_like).to eq('0 °C')
    end

    it 'return fahrenheit' do
      presenter = described_class.new(weather: weather_json, temp_scale: 'fahrenheit')
      expect(presenter.temperature).to eq('32.0 °F')
      expect(presenter.feels_like).to eq('32.0 °F')
    end

    it 'return kelvin' do
      presenter = described_class.new(weather: weather_json, temp_scale: 'kelvin')
      expect(presenter.temperature).to eq('273 °K')
      expect(presenter.feels_like).to eq('273 °K')
    end
  end
end