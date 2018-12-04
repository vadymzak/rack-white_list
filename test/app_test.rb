require_relative '../lib/my_app'
require_relative '../lib/myrackmiddleware'
require_relative '../lib/config_load'
require_relative '../lib/white_list_checker'

require 'pry'
require 'test/unit'
require 'rack/test'
# Test
class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MyRackMiddleware.new(MyApp.new)
  end

  def test_status_401_with_without_token
    get '/'
    assert_equal last_response.status, 401
  end

  def test_status_401_with_domen_authh_signup
    get 'http://authh.com/signup'
    assert_equal(last_response.status, 401)
  end

  def test_status_200_with_domen_auth_signup
    get 'http://auth.com/signup'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_auth_signupp
    get 'http://auth.com/signupp'
    assert_equal(last_response.status, 401)
  end

  def test_status_200_with_domen_resources_countries_method_get
    get 'http://resources.com/countries'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_resources_countriess_method_get
    get 'http://resources.com/countriess'
    assert_equal(last_response.status, 401)
  end

  def test_status_200_with_domen_dots_test_method_get
    get 'http://dots.com/test'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_dots_tests_method_get
    get 'http://dots.com/tests'
    assert_equal(last_response.status, 401)
  end

  def test_status_200_with_domen_dots_test_method_post
    post 'http://dots.com/test'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_dots_testt_method_post
    post 'http://dots.com/testt'
    assert_equal(last_response.status, 401)
  end

  def test_status_200_with_domen_dots_signin
    get 'http://dots.com/signin'
    assert_equal(last_response.status, 200)
  end

  def test_status_200_with_domen_dots_signin_id
    get 'http://dots.com/signin/id'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_dots_signinn_id
    get 'http://dots.com/signinn/id'
    assert_equal(last_response.status, 401)
  end
end
