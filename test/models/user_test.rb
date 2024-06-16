require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without name" do
    user = User.new

    assert_not user.save
    assert user.errors.added?(:name, :blank)
  end

  test "should not save user without email" do
    user = User.new

    assert_not user.save
    assert user.errors.added?(:email, :blank)
  end

  test "filter active/inactive users" do
    User.create!(
      [
        { name: "John Doe", email: "jdoe@example.com", active: true },
        { name: "Jane Doe", email: "jane_doe@example.com", active: false },
      ]
    )

    assert_equal 1, User.actives.count
    assert_equal 1, User.inactive.count
    assert_equal 'John Doe', User.actives.first.name
    assert_equal 'Jane Doe', User.inactive.first.name
  end

  test "filter admin users" do
    User.create!(
      [
        { name: "John Doe", email: "jdoe@example.com", admin: true },
        { name: "Jane Doe", email: "jane_doe@example.com", admin: false },
      ]
    )

    assert_equal 1, User.admins.count
    assert_equal 'John Doe', User.admins.first.name
  end
end
