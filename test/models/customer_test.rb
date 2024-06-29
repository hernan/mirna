# frozen_string_literal: true

require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "Should have a name" do
    cus = Customer.new

    assert_not cus.valid?
    assert_predicate cus.errors[:name], :present?
  end

  test "Should have an unique name" do
    Customer.create!(name: "Some name", email: "some@email.com")
    cus = Customer.new(name: "Some name", email: "other@email.com")

    assert_not cus.valid?
    assert_match "taken", cus.errors[:name].join(" ")
  end

  test "Should have an email" do
    cus = Customer.new

    assert_not cus.valid?
    assert_predicate cus.errors[:email], :present?
  end

  test "Should have an unique email" do
    Customer.create!(name: "Some name", email: "some@email.com")
    cus = Customer.new(name: "Other name", email: "some@email.com")

    assert_not cus.valid?
    assert_match "taken", cus.errors[:email].join(" ")
  end

  test "Could have an empty host" do
    cus = Customer.new(name: "some name", email: "some@email.com")

    assert_predicate cus, :valid?
  end

  test "Should be an unique host if present" do
    Customer.create!(name: "some name", email: "some@email.com", host: "the_host")
    cus = Customer.new(name: "other name", email: "other@email.com", host: "the_host")

    assert_not cus.valid?
    assert_match "taken", cus.errors[:host].join(" ")
  end
end
