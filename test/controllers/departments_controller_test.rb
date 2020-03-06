require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest

  test "test index" do
    get '/departments'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 3, data.length
  end

end
