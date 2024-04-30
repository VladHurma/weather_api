require 'rails_helper'

RSpec.describe OpenWeatherApiClient do
  let(:location) { 'Test' }
  let(:open_weather_api_client) { described_class.new(location: location) }
  let(:weather_mock) { {'test' => 'test'} }

  it 'return nil if there is no coordinates' do
    allow_any_instance_of(described_class).to receive(:request_weather_data).and_return(weather_mock)
    expect(open_weather_api_client.request_weather_data).to eq(weather_mock)
  end
end