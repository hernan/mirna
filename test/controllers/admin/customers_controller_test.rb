# frozen_string_literal: true

require "test_helper"

class Admin::CustomerControllerTest < ActionDispatch::IntegrationTest
  test "Should redirect to login if not logged in" do
    get admin_customers_url

    assert_response :redirect
    assert_redirected_to admin_login_url
  end

  test "Should redirect to login if not admin" do
    login(regular_user)

    get admin_customers_url

    assert_response :redirect
    assert_redirected_to admin_login_url
  end

  test "Should render index if logged in" do
    login(admin_user)

    get admin_customers_url

    assert_response :success
  end
end
