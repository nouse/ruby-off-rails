require './notes'

use Rack::MethodOverride
use Rack::CommonLogger
run Notes
