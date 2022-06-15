class ApplicationController < ActionController::API
  def geo_locate
    @location = LocationFacade.get_location(params[:location])
  end

  def find_weather(route, lat, lon)
    if route.travel_time[0..1].to_i < 8
      WeatherFacade.get_hourly_weather(lat, lon)
    else
      WeatherFacade.get_daily_weather(lat, lon)
    end
  end
end
