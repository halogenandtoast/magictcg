class UsersController < ApplicationController
  skip_before_filter :require_login
  respond_to :html

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)
    sign_in(@user)
    respond_with @user, location: destination
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def destination
    if signed_in?
      dashboard_path
    else
      root_path
    end
  end
end

