# frozen_string_literal: true

class Admin::AuthController < Admin::BaseController
  skip_before_action :authenticate_admin_user, only: [:new, :create]

  def new
    return redirect_to :admin_dashboard if current_user
    @user = User.new
  end

  def create
    uparams = params[:user] || {}
    user = User.authenticate_by email: uparams[:email], password: uparams[:password]

    if user&.is_admin?
      login user
      redirect_to :admin_dashboard
    else
      flash.now[:error] = "Incorrect email or password"
      @user = User.new(email: uparams[:email])

      render :new, status: :unprocessable_entity
    end
  end

  def delete
    logout
    redirect_to :admin_login
  end

  private
    def admin_params
      params.require(:user)
            .permit(:email, :password)
    end
end
