require 'capybara/rspec'
require 'ffaker'
require 'ohm'
require 'fabrication'
require 'text_helpers'
require 'custom_method_override'
require 'cuba'

Ohm.connect :db => 1, :driver => :hiredis

RSpec.configure do |config|
  config.include TextHelpers, :type => :feature

  config.before(:each) do |example|
    Ohm.flush
  end
end

CUBA_ROOT = File.dirname(__FILE__)+'/..' 
Cuba.use Rack::CustomMethodOverride
Capybara.app = Cuba

require CUBA_ROOT+'/app'

Note.instance_eval do
  def count
    all.size
  end
end

Fabricator(:note) do
  title { generate_description }
  body  { generate_content }
end

def generate_description
  Faker::Lorem.sentence
end

def generate_content
  Faker::Lorem.paragraph
end
