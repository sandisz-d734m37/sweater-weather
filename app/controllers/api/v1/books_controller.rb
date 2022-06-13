class Api::V1::BooksController < ApplicationController
  def index
    params[:location] = "Nowhere" unless params[:location]
    
    @location = LocationFacade.get_location(params[:location])
    @current_weather = WeatherFacade.get_current_weather(@location.lat, @location.lon)
    @books = BookFacade.get_books(params[:location], params[:quantity])
    render json: BookSerializer.books(@current_weather, @books, params[:location])
  end
end
