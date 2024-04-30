require 'rails_helper'

RSpec.describe TrackTelemetry do
  let(:dummy_class) { Class.new { include TrackTelemetry } }
  let(:dummy_object) { dummy_class.new }

  it 'return no block error' do
    expect{ dummy_object.run_with_telemetry(span_name: '', attributes: '')}.to raise_error('No block given to the span')
  end

  it 'returns block result' do
    expect{ |block| dummy_object.run_with_telemetry(span_name: '', attributes: '', &block) }.to yield_control
  end
end