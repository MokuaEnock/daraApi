class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {
               error: {
                 login: "Invalid email or password"
               }
             },
             status: :unauthorized
    end
  end
end
