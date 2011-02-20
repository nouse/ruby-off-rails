require 'spork'

require 'capybara/dsl'
require 'faker'
require 'steak'
require 'sinatra'
require 'sequel'
require 'spawn'

Spork.prefork do
  SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
  $LOAD_PATH << SINATRA_ROOT
  DB = Sequel.amalgalite
  set :environment, :test
  set :root, SINATRA_ROOT
end

Capybara.app = Sinatra::Application

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

Note.extend Spawn
Note.spawner do |user|
  user.title = generate_description
  user.body  = generate_content
end
