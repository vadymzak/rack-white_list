require './lib/my_app'
require './lib/myrackmiddleware'
require './lib/config_load'
require './lib/white_list_checker'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new
