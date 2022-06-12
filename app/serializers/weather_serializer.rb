class WeatherSerializer
  include JSONAPI::Serializer

  def self.weather_index(current_weather, daily_weather, hourly_weather)
    {
      data: {
        id: nil,
        type: "forecast",
        attributes: {
          current_weather: {
            datetime: current_weather.datetime,
            sunrise: current_weather.sunrise,
            sunset: current_weather.sunset,
            temperature: current_weather.temperature,
            feels_like: current_weather.feels_like,
            humidity: current_weather.humidity,
            uvi: current_weather.uvi,
            visibility: current_weather.visibility,
            conditions: current_weather.conditions,
            icon: current_weather.icon
          },
          daily_weather: daily_weather.map do |weather|
            {
              date: weather.date,
              sunrise: weather.sunrise,
              sunset: weather.sunset,
              max_temp: weather.max_temp,
              min_temp: weather.min_temp,
              conditions: weather.conditions,
              icon: weather.icon
            }
          end,
          hourly_weather: hourly_weather.map do |weather|
            {
              time: weather.time,
              temperature: weather.temperature,
              conditions: weather.conditions,
              icon: weather.icon
            }
          end
        }
      }
    }
  end
end
