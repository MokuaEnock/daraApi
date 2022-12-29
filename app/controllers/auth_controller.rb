class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
