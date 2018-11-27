require './my_app'
require './myrackmiddleware'
require './loadConfig'
require './check_white_list'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new
