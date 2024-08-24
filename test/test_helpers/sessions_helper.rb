# frozen_string_literal: true

module SessionsHelper
  def parsed_cookies
    ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
  end

  def login(user)
    post admin_login_url, params: { user: { email: user.email, password: "password" } }
    # assert_predicate cookies[:session_token], :present?
    assert_predicate session[:user_id], :present?
  end

  def logout
    delete admin_logout_url
    # assert_not cookies[:session_token].present?
    assert_predicate session[:user_id], :blank?
  end

  def admin_user
    User.create!(
      name: "John Doe",
      email: "john@doe.com",
      password: "password",
      password_confirmation: "password",
      admin: true
    )
  end

  def regular_user
    User.create!(
      name: "John Doe",
      email: "john@doe.com",
      password: "password",
      password_confirmation: "password"
    )
  end
end
