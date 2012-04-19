require 'sequel'
DB = Sequel.connect("postgres:///notes_dev")

DB.create_table?(:notes) do
  primary_key :id
  text :title
  text :body
end

require './notes'
run Sinatra::Application
