class RoadTripSerializer
  include JSONAPI::Serializer

  def self.create_road_trip(road_trip, weather)
    {
      data: {
        id: nil,
        type: "roadtrip",
        attributes: {
          start_city: road_trip.start_city,
          end_city: road_trip.end_city,
          travel_time: road_trip.travel_time,
          weather_at_eta:
          if weather[0].class == HourlyWeather
            {
              temperature: weather[road_trip.travel_time[0..1].to_i].temperature,
              conditions: weather[road_trip.travel_time[0..1].to_i].conditions
            }
          elsif weather[0].class == DailyWeather
            {
              temperature: weather[road_trip.travel_time_in_days].max_temp,
              conditions: weather[road_trip.travel_time_in_days].conditions
            }
          end
        }
      }
    }
  end

  def self.road_trip_impossible(origin, destination)
    {
      data: {
        id: nil,
        type: "roadtrip",
        attributes: {
          start_city: origin,
          end_city: destination,
          travel_time: "impossible",
          weather_at_eta: {}
        }
      }
    }
  end
end
