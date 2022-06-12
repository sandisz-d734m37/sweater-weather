class Api::V1::WeatherController < ApplicationController
  before_action :geo_locate, only: [:index]

  def index
    @current_weather = WeatherFacade.get_current_weather(@location.lat, @location.lon)
    @daily_weather = WeatherFacade.get_daily_weather(@location.lat, @location.lon)
    @hourly_weather = WeatherFacade.get_hourly_weather(@location.lat, @location.lon)
    render json: WeatherSerializer.weather_index(@current_weather, @daily_weather, @hourly_weather)
  end
end
