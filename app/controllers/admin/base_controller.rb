# frozen_string_literal: true

class Admin::BaseController < ActionController::Base
  default_form_builder MyFormBuilder
  before_action :authenticate_admin_user
  layout "admin"


  private
    def authenticate_admin_user
      redirect_to admin_login_path unless current_user&.is_admin?
    end

    def current_user
      Current.user ||= authenticate_user_from_session
    end
    helper_method :current_user

    def signed_in?
      current_user.present?
    end
    helper_method :signed_in?

    def authenticate_user_from_session
      uid = session[:user_id]
      return if uid.blank?

      User.find_by(id: uid)
    end

    def login(user)
      Current.user = user
      reset_session
      session[:user_id] = user.id
    end

    def logout
      Current.user = nil
      reset_session
    end
end
