class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: UserSerializer.register(user), status: :created
    else
      render json: ErrorSerializer.error_with_status(:credentials)
    end
  end
end
