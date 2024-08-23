# frozen_string_literal: true

class Admin::AuthController < Admin::BaseController
  skip_before_action :authenticate_admin_user, only: [:new, :create]

  def new
    return redirect_to :admin_dashboard if signed_in?

    @user = User.new
  end

  def create
    user = User.authenticate_by email: params[:email], password: params[:password]

    if user
      login user
      redirect_to :admin_dashboard
    else
      flash.now[:notice] = "Incorrect email or password"
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
