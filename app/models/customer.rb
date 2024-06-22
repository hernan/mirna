# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :host, uniqueness: true, allow_nil: true
end
