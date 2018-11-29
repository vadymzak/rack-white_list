
require 'pry'

class MyRackMiddleware
  attr_reader :request

  def initialize(appl)
    @appl = appl
    @check_wl =  WhiteListChecker.new
  end

  def call(env)
    @env = env
    request(env)
    status, headers, body = @appl.call(env) # we now call the inner application
    if @check_wl.host_present?(http_host, path_info, request_method)
      response_rack("200", "Success")
    else
      response_rack("401", "Failed")
    end
  end

  private

  def request(env)
    @request = Rack::Request.new(env)
  end

  def response_rack(status, header)
    resp = Rack::Response.new
    resp.status = status
    resp.set_header("X-Auth-User", header)
    resp.finish
  end

  def request_method
    @env['REQUEST_METHOD']
  end

  def http_host
    @env['HTTP_HOST']
  end

  def path_info
    @env['PATH_INFO']
  end

end
