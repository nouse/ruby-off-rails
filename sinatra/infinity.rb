require 'rubygems'
require 'sinatra'

use Rack::CommonLogger
use Rack::ShowExceptions

get '/' do
  "Hello, Sinatra"
end

get '/version' do
  "infinity 0.1"
end

get '/version/last' do
  "infinity beta 0.13"
end
