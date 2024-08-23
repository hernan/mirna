# frozen_string_literal: true

require "test_helper"

class Admin::AuthControllerTest < ActionDispatch::IntegrationTest
  test "Should render login form" do
    get admin_login_url

    assert_response :success
  end

  test "Should redirect to dashboard if logged in" do
    login(admin_user)

    get admin_login_url

    assert_response :redirect
    assert_redirected_to admin_dashboard_url
  end

  test "Should redirect to login if not logged in" do
    delete admin_logout_url

    assert_response :redirect
    assert_redirected_to admin_login_url
  end

  test "Should redirect to login if not admin" do
    login(regular_user)

    delete admin_logout_url

    assert_response :redirect
    assert_redirected_to admin_login_url
  end

  test "Should logout if logged in" do
    login(admin_user)

    delete admin_logout_url

    assert_response :redirect
    assert_redirected_to admin_login_url
  end
end
