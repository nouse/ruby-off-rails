class Nothing
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  end
end

use Nothing
use Rack::CommonLogger

map '/' do
  run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ["Hello, Rack"]]}
end
