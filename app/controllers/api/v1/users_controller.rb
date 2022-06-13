class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    user.api_key = SecureRandom.alphanumeric(16)

    if user.save
      render json: UserSerializer.register(user), status: :created
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
