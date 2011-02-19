SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
$LOAD_PATH << SINATRA_ROOT
require 'capybara/dsl'
require 'faker'
require 'steak'
require 'sinatra'
require 'sequel'

DB = Sequel.amalgalite
Capybara.app = Sinatra::Application

set :environment, :test
set :root, SINATRA_ROOT

require 'notes'

RSpec.configure do |config|
  config.include Capybara
  config.include TextHelper
  config.mock_with :rspec
end

def generate_description
  Faker::Lorem.sentence
end

def generate_content
  Faker::Lorem.paragraph
end
