require 'capybara/rspec'
require 'ffaker'
require 'ohm'
require 'machinist/object'
require 'text_helpers'
require 'cuba'

Ohm.connect :db => 1

RSpec.configure do |config|
  config.include TextHelpers, :type => :request
  config.include TextHelpers, :type => :acceptance

  config.before(:each) do |example|
    Ohm.flush
  end
end

CUBA_ROOT = File.dirname(__FILE__)+'/..' 
Capybara.app = Cuba

require CUBA_ROOT+'/app'

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
