require 'rails_helper'

RSpec.describe ApiRequest do
  let(:url) { 'test.test' }
  let(:params) { Array.new }
  let(:net_url) do
    net_url = URI(url)
    net_url.query = URI.encode_www_form(params)
    net_url
  end
  let(:body_mock) { OpenStruct.new(body: '{"test_key": "test_value"}') }
  let(:dummy_class) { Class.new { include ApiRequest } }
  let(:dummy_object) { dummy_class.new }

  it 'returns JSON' do
    allow(Net::HTTP).to receive(:get_response).with(net_url).and_return(body_mock)
    expect(dummy_object.perform_request(request_url: url, request_params: params)).to eq(JSON(body_mock.body))
  end
end