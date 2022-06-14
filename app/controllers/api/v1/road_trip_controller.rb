class Api::V1::RoadTripController < ApplicationController
  def create
    binding.pry
    user = User.find_by(api_key: params[:road_trip][:api_key])
    if user
      route = RouteFacade.get_route(params[:road_trip][:origin], params[:road_trip][:destination])
      if route.travel_time[0..1].to_i < 8
        weather = WeatherFacade.get_hourly_weather(route.end_lat, route.end_lon)
      else
        weather = WeatherFacade.get_daily_weather(route.end_lat, route.end_lon)
      end
      road_trip = user.roadtrips.create(start_city: route.start_city, end_city: route.end_city, travel_time: route.start_city)
    end
  end
end
