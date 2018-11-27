require_relative "../app/my_app"
require_relative "../app/myrackmiddleware"
require_relative "../app/loadConfig"
require_relative "../app/check_white_list"

require 'pry'
require "test/unit"
require "rack/test"

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MyRackMiddleware.new(MyApp.new)
  end

  # def test_status_401_with_without_token
  #   get "/"
  #
  #   assert_equal last_response.status, 401
  # end
  def test_request_method_get
    get 'https://auth.com'

    assert_equal(last_response.status, 200 )
  end



  # def test_status_401_with_not_valid_token
  #   get "/?token=sdfsdfszg"
  #
  #   assert_equal last_response.status, 401
  # end
  #
  # def test_status_200_with_hs256_valid_token_in_params
  #   payload = { data: 'test' }
  #   @valid = JWT.encode payload, HMAC_KEY, 'HS256'
  #
  #   get "/?token=Bearer #{@valid}"
  #
  #   assert_equal last_response.status, 200
  # end
  #
  # def test_status_200_with_hs256_valid_token_in_header
  #   payload = { data: 'test' }
  #   @valid = JWT.encode payload, HMAC_KEY, 'HS256'
  #
  #   header 'AUTHORIZATION', "Bearer #{@valid}"
  #   get "/"
  #
  #   assert_equal last_response.status, 200
  # end

end
