# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def new
    user = User.new

    render locals: { user: }
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to admin_users_path
    else
      render "new", locals: { user: }, status: :unprocessable_content
    end
  end

  def edit
    user = User.find(params[:id])

    render locals: { user: }
  end

  def update
    user = User.find(params[:id])

    if user.save
      redirect_to admin_users_path
    else
      render "edit", locals: { user: }
    end
  end

  private
    def user_params
      params.require(:user)
            .permit(
              :name,
              :email,
              :password
            )
    end
end
