require 'capybara/rspec'
require 'ffaker'
require 'sinatra'
require 'sequel'
require 'machinist/sequel'
require 'text_helpers'

RSpec.configure do |config|
  config.include TextHelpers, :type => :request
  config.include TextHelpers, :type => :acceptance
end

SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
DB = Sequel.amalgalite
set :environment, :test
set :root, SINATRA_ROOT
Capybara.app = Sinatra::Application

require SINATRA_ROOT+'/notes'

Note.blueprint do
  title { generate_description }
  body  { generate_content }
end

def generate_description
  Faker::Lorem.sentence
end

def generate_content
  Faker::Lorem.paragraph
end
