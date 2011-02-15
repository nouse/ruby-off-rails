require 'rubygems'
require 'sinatra'

SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
$LOAD_PATH << SINATRA_ROOT
require 'notes'
#Sinatra::Application.app_file = app_file

require 'capybara'
require 'capybara/dsl'
require 'steak'

Capybara.app = Sinatra::Application

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
set :root, SINATRA_ROOT

RSpec.configure do |config|
  config.include Capybara
  config.mock_with :rspec
end
