require_relative "../lib/my_app"
require_relative "../lib/myrackmiddleware"
require_relative "../lib/config_load"
require_relative "../lib/white_list_checker"

require 'pry'
require "test/unit"
require "rack/test"

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MyRackMiddleware.new(MyApp.new)
  end

  def test_status_401_with_without_token
    get "/"

    assert_equal last_response.status, 401
  end

  def test_status_200_with_domen_auth
    get 'http://auth.com/signup'

    assert_equal(last_response.status, 200 )
  end

  def test_status_200_with_domen_auth_id
    get 'http://auth.com/signup/id'

    assert_equal(last_response.status, 200 )
  end

  def test_status_200_with_domen_resources_countries_method_GET
    get 'http://resources.com/countries'

    assert_equal(last_response.status, 200 )
  end

  def test_status_200_with_domen_dots_signin
    get 'http://dots.com/signin'

    assert_equal(last_response.status, 200 )
  end

  def test_status_200_with_domen_dots_test_method_GET
    get 'http://dots.com/test'

    assert_equal(last_response.status, 200 )
  end

  def test_status_200_with_domen_dots_test_method_POST
    post 'http://dots.com/test'

    assert_equal(last_response.status, 200 )
  end

end
