class MethodOverride
  HTTP_METHODS = %w(GET POST PUT DELETE)
  METHOD_OVERRIDE_PARAM_KEY = "_method".freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    method = req.GET[METHOD_OVERRIDE_PARAM_KEY]
    method = method.to_s.upcase
    env["REQUEST_METHOD"] = method if HTTP_METHODS.include?(method)      
    @app.call(env)
  end
end

use MethodOverride
use Rack::CommonLogger

map '/' do
  run Proc.new {|env| [200, {"Content-Type" => "text/html"},
                        ["REQUEST_METHOD: #{env['REQUEST_METHOD']}"]]}
end
