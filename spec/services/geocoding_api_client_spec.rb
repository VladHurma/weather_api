require 'rails_helper'

RSpec.describe GeocodingApiClient do
  let(:location) { 'Test' }
  let(:geo_mock) { [{ 'lat' => 0, 'lon' => 0 }] }
  let(:geocoding_api_client) { described_class.new(location: location) }

  it 'return latitude and longitude' do
    allow_any_instance_of(described_class).to receive(:request_geocoding_info).and_return(geo_mock)
    geo_mock_hash = geo_mock.first&.symbolize_keys
    expect(geocoding_api_client.geo_coordinates).to eq(geo_mock_hash)
  end

  it 'return nil if not found' do
    allow_any_instance_of(described_class).to receive(:request_geocoding_info).and_return([])
    expect(geocoding_api_client.geo_coordinates).to eq(nil)
  end
end