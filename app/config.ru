require './my_app'
require './myrackmiddleware'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new
