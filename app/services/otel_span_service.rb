class OtelSpanService
  require "opentelemetry/sdk"
  NON_PROV_ENVS = %w[test development]

  def self.do_span(span_name:, attributes:)
    if block_given?
      Rails.env.in?(NON_PROV_ENVS) ? yield : MyAppTracer.in_span(span_name, attributes: attributes) { yield }
    else
      raise 'No block given to the span'
    end
  end
end