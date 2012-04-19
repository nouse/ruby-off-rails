module Rack
  class CustomMethodOverride
    HTTP_METHODS = %w(PUT DELETE)

    METHOD_OVERRIDE_PARAM_KEY = "_method".freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      if env["REQUEST_METHOD"] == "POST"
        method = method_override(env)
        if HTTP_METHODS.include?(method)
          env["rack.methodoverride.original_method"] = env["REQUEST_METHOD"]
          env["REQUEST_METHOD"] = method
        end
      end

      @app.call(env)
    end

    def method_override(env)
      req = Request.new(env)
      method = req.GET[METHOD_OVERRIDE_PARAM_KEY]
      method.to_s.upcase
    rescue EOFError
      ""
    end
  end
end
