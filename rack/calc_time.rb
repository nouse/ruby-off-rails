def float_ms
  Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_millisecond)
end

class CalcTime
  def initialize(app)
    @app = app
  end

  def call(env)
    now = float_ms
    status, headers, body = @app.call(env)
    elasped = float_ms - now
    string = sprintf("Time elapsed: %.4f ms\n", elasped)
    response = body.unshift(string)
    [status, headers, response]
  end
end

