require 'rails_helper'

RSpec.describe OtelSpanService do
  it 'return no block error' do
    expect{ described_class.do_span(span_name: '', attributes: '')}.to raise_error('No block given to the span')
  end

  it 'returns block result' do
    expect{ |block| described_class.do_span(span_name: '', attributes: '', &block) }.to yield_control
  end
end