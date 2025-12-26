class CalcTime
  def initialize(app)
    @app = app
  end

  def call(env)
    now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    status, headers, body = @app.call(env)
    string = "<p>Time elapsed: #{Process.clock_gettime(Process::CLOCK_MONOTONIC)-now}</p>"
    response = body.collect{|e| e}.unshift(string)
    [status, headers, response]
  end
end

use Rack::CommonLogger
use Rack::ContentLength
use CalcTime

map '/' do
  run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ["Hello, Rack"]]}
end
