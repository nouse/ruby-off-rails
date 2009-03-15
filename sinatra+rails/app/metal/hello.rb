require 'sinatra/base'

class Hello < Sinatra::Base
  # all options are available for the setting:
  enable :static, :session
  set :root, File.dirname(__FILE__)

  # each subclass has its own private middleware stack:
  #use Rack::Deflater

  get '/sinatra' do
    "Hello, sinatra"
  end
end
