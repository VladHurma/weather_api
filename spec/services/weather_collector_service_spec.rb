require 'rails_helper'

RSpec.describe WeatherCollectorService do
  let(:weather_object) { described_class.new('Test') }
  let(:coordinates_mock) { { test: nil } }

  it 'returns nil if coordinates empty' do
    allow_any_instance_of(described_class).to receive(:collect_coordinates).and_return(coordinates_mock)
    expect(weather_object.perform).to eq(nil)
  end
end