require 'sequel'
DB = Sequel.connect("amalgalite://notes.sqlite")

require './notes'
run Sinatra::Application
