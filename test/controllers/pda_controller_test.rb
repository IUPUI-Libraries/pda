require 'test_helper'

class PdaControllerTest < ActionController::TestCase
  test "should get request" do
    get :request
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
