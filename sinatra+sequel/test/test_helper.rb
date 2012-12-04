require 'capybara/dsl'
require 'ffaker'
require 'sinatra'
require 'sequel'
require 'fabrication'
require_relative '../lib/text_helpers'

class Cutest::Scope
  include TextHelpers
  include Capybara::DSL
end

SINATRA_ROOT = File.dirname(__FILE__)+'/..'
DB = Sequel.connect('postgres:///notes_test')
require_relative '../lib/note'
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

module Kernel
  private
  def db(&block)
    DB.transaction {
      yield
      raise Sequel::Rollback
    }
  end
end
