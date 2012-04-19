require 'sequel/model'

class Note < Sequel::Model
  plugin :prepared_statements_safe
  plugin :forme
end
