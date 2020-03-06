require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  test "test pages count" do
    get '/products'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal data["meta"]["pages_count"], 4
  end

  test "test pagination size" do
    get '/products'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 6, data["products"].length
  end

  test "test active promotion" do
    get '/products?code=act25'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal data["products"].length, 3
    data["products"].each do |product|
      assert_equal "act25", product["promotion"]["code"]
    end
  end

  test "test inactive promotion" do
    get '/products?code=pro30'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test does not exist promotion" do
    get '/products?code=notexist'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test search for part of a product name" do
    get '/products?search=spor'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 3, data["products"].length
    data["products"].each do |product|
      assert_includes product["name"], "Spor"
    end
  end

  test "test search for non exist word" do
    get '/products?search=notexist'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test filter with search and promo" do
    get '/products?code=act25&search=ele'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 2, data["products"].length
    data["products"].each do |product|
      assert_includes product["name"], "Elec"
      assert_equal "act25", product["promotion"]["code"]
    end
  end

  test "test filter with search and invalid promo" do
    get '/products?code=inv&search=ele'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test filter with search and inactive promo" do
    get '/products?code=pro30&search=ele'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test filter search and promo with not matching search" do
    get '/products?code=act25&search=non'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test department filter" do
    get '/products?department_ids[]=8'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 3, data["products"].length
    data["products"].each do |product|
      assert_includes product["name"], "Spor"
    end
  end

  test "test filter with multiple departments" do
    get '/products?department_ids[]=8&department_ids[]=7'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 6, data["products"].length
    assert_equal 2, data["meta"]["pages_count"]
  end

  test "test filter with one valid department and other invalid" do
    get '/products?department_ids[]=8&department_ids[]=18'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 3, data["products"].length
    data["products"].each do |product|
      assert_includes product["name"], "Spor"
    end
  end

  test "test filter with invalid department IDs" do
    get '/products?department_ids[]=80&department_ids[]=18'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test search, promo and depratments filter" do
    get '/products?code=act25&search=ele&department_ids[]=7'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 2, data["products"].length
    data["products"].each do |product|
      assert_includes product["name"], "Elec"
      assert_equal "act25", product["promotion"]["code"]
    end
  end

  test "test search, promo and depratments with valid data but no result" do
    get '/products?code=act25&search=ele&department_ids[]=8'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 0, data["products"].length
  end

  test "test promo and multiple department filter" do
    get '/products?code=act25&department_ids[]=7&department_ids[]=9'
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal 3, data["products"].length
  end



end
