require 'rack/common_logger'
require 'refrigerator'
require_relative 'calc_time'

class App
  def call(_)
    return [200, {"Content-Type" => "text/plain"}, ["Hello, Rack"]]
  end
end

require 'nio' if defined?(Puma)
Refrigerator.freeze_core

use Rack::CommonLogger
use CalcTime

run App.new
