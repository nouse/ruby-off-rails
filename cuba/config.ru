require 'sequel'

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")
require 'text_helpers'

DB = Sequel.connect("postgres:///notes_dev")

DB.create_table?(:notes) do
  primary_key :id
  text :title
  text :body
end


require './app'
run Cuba
