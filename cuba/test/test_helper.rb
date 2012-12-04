require 'cuba/capybara'
require 'ffaker'
require 'ohm'
require 'fabrication'
require_relative '../lib/text_helpers'
require_relative '../lib/custom_method_override'
require 'cuba'

Ohm.connect :db => 1, :driver => :hiredis

prepare do
  Ohm.flush
end

class Cutest::Scope
  include TextHelpers
end

CUBA_ROOT = File.dirname(__FILE__)+'/..' 
Cuba.use Rack::CustomMethodOverride

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
