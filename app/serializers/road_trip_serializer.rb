class RoadTripSerializer
  include JSONAPI::Serializer

  def self.create_road_trip(route, weather)
    {
      data: {
        id: nil,
        type: "roadtrip",
        attributes: {
          start_city: route.start_city,
          end_city: route.end_city,
          travel_time: route.travel_time,
          weather_at_eta: {
            temperature: weather[route.travel_time[0..1].to_i].temperature,
            conditions: weather[route.travel_time[0..1].to_i].conditions
          }
        }
      }
    }
  end
end
