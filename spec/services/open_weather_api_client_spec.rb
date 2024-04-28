require 'rails_helper'

RSpec.describe OpenWeatherApiClient do
  let(:location) { 'Test' }
  let(:open_weather_api_client) { described_class.new(location: location) }

  it 'return nil if there is no coordinates' do
    allow_any_instance_of(described_class).to receive(:location_coordinates).and_return(nil)
    expect(open_weather_api_client.weather_data).to eq(nil)
  end
end