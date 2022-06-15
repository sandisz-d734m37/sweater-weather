class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      route = RouteFacade.get_route(params[:origin], params[:destination])

      if route.class == String
        render json: RoadTripSerializer.road_trip_impossible(params[:origin], params[:destination])
      else

        weather = find_weather(route, route.end_lat, route.end_lon)

        road_trip = user.road_trips.create(start_city: route.start_city, end_city: route.end_city, travel_time: route.travel_time)
        if road_trip.save
          render json: RoadTripSerializer.create_road_trip(road_trip, weather), status: :created
        end
      end
    else
      render json: ErrorSerializer.error_with_code(401), status: 401
    end
  end
end
