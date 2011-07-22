require 'bundler/setup'

require 'sequel'
DB = Sequel.connect("postgres:///notes_dev")

require './notes'
run Sinatra::Application
