require './lib/my_app'
require './lib/myrackmiddleware'
require './lib/config_load'
require './lib/check_white_list'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new
