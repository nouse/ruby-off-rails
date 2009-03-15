class CalcTime
  def initialize(app)
    @app = app
  end

  def call(env)
    now = Time.now
    status, headers, body = @app.call(env)
    string = "Time elapsed: #{Time.now-now}\n"
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
