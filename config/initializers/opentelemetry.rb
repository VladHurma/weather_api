require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry-exporter-zipkin'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'weather_api'
  c.use_all() # enables all instrumentation!
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('weather_api')