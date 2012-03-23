require 'ohm'

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")
require 'text_helpers'

Ohm.connect :db => 0

require './app'
run Cuba
