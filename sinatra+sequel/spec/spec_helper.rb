require 'capybara/rspec'
require 'ffaker'
require 'sinatra'
require 'sequel'
require 'fabrication'
require 'text_helpers'

RSpec.configure do |config|
  config.include TextHelpers, :type => :feature

  config.around(:each) do |example|
    DB.transaction { example.run; raise Sequel::Rollback }
  end
end

SINATRA_ROOT = File.dirname(__FILE__)+'/..' 
DB = Sequel.connect('postgres:///notes_test')
require 'note'
set :environment, :test
set :root, SINATRA_ROOT
Capybara.app = Sinatra::Application

require SINATRA_ROOT+'/notes'

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
