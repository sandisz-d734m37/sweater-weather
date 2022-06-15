class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    user.api_key = SecureRandom.alphanumeric(16)

    if user.save
      render json: UserSerializer.register(user), status: :created
    elsif User.find_by(email: params[:email])
      render json: ErrorSerializer.error_with_status(:already_exists), status: 409
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
