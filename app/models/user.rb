# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :actives, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :admins, -> { where(admin: true) }
end
