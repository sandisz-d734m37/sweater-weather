class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      route = RouteFacade.get_route(params[:origin], params[:destination])
      if route.travel_time[0..1].to_i < 8
        weather = WeatherFacade.get_hourly_weather(route.end_lat, route.end_lon)
      else
        weather = WeatherFacade.get_daily_weather(route.end_lat, route.end_lon)
      end
      road_trip = user.road_trips.create(start_city: route.start_city, end_city: route.end_city, travel_time: route.travel_time)
      if road_trip.save
        render json: RoadTripSerializer.create_road_trip(road_trip, weather), status: :created
      end
    end
  end
end
