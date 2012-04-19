require 'ohm'

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")
require 'text_helpers'
require 'custom_method_override'

Ohm.connect :db => 0

require './app'
Cuba.use Rack::CustomMethodOverride
run Cuba
