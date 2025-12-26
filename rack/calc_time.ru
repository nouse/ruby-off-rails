require 'rack/common_logger'
require 'refrigerator'

class CalcTime
  def initialize(app)
    @app = app
  end

  def call(env)
    now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    status, headers, body = @app.call(env)
    elasped = Process.clock_gettime(Process::CLOCK_MONOTONIC)-now
    string = sprintf("Time elapsed: %.6f\n", elasped)
    response = body.unshift(string)
    [status, headers, response]
  end
end

require 'nio' if defined?(Puma)
Refrigerator.freeze_core

use Rack::CommonLogger
use CalcTime

map '/' do
  run Proc.new {|env| [200, {"Content-Type" => "text/plain"}, ["Hello, Rack"]]}
end

Rack::Builder.new do

end
