require "cutest"
require "capybara/dsl"
require 'faker'
require 'sinatra'
require 'sequel'

SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
$LOAD_PATH << SINATRA_ROOT

set :environment, :test
set :root, SINATRA_ROOT

DB = Sequel.amalgalite
Capybara.app = Sinatra::Application

require 'notes'

class Cutest::Scope
  include Capybara
  include TextHelper
end

def generate_description
  Faker::Lorem.sentence
end

def generate_content
  Faker::Lorem.paragraph
end
