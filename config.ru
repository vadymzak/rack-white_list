require './app/my_app'
require './app/myrackmiddleware'
require './app/config_load'
require './app/check_white_list'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new
