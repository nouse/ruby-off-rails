require 'steak'
require 'capybara/rspec'
require 'ffaker'
require 'sinatra'
require 'sequel'
require 'spawn'
require 'text_helpers'

RSpec.configure do |config|
  config.include TextHelpers
end

SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
DB = Sequel.amalgalite
set :environment, :test
set :root, SINATRA_ROOT
Capybara.app = Sinatra::Application

require SINATRA_ROOT+'/notes'

Note.extend Spawn
Note.spawner do |user|
  user.title = generate_description
  user.body  = generate_content
end

def generate_description
  Faker::Lorem.sentence
end

def generate_content
  Faker::Lorem.paragraph
end
