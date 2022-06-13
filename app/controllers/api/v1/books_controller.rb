class Api::V1::BooksController < ApplicationController
  def index
    @location = LocationFacade.get_location(params[:location])
    @current_weather = WeatherFacade.get_current_weather(@location.lat, @location.lon)
    @books = BookFacade.get_books(params[:location], params[:quantity])
    render json: BooksSerializer.books(@current_weather, @books)
  end
end
