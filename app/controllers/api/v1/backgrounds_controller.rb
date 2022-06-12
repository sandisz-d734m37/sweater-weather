class Api::V1::BackgroundsController < ApplicationController
  def show
    @background_image = ImageFacade.get_background_image(params[:location])
    render json: BackgroundSerializer.background(@background_image)
  end
end
