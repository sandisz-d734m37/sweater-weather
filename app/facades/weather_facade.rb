class WeatherFacade
  class << self
    def get_weather(lat, lon)
      @weather_data = WeatherService.get_weather_data(lat, lon)
    end

    def get_current_weather(lat, lon)
      get_weather(lat, lon)

      CurrentWeather.new(@weather_data[:current])
    end

    def get_daily_weather(lat, lon)
      get_weather(lat, lon)

      @weather_data[:daily][0..4].map do |data|
        DailyWeather.new(data)
      end
    end

    def get_hourly_weather(lat, lon)
      get_weather(lat, lon)

      @weather_data[:hourly][0..7].map do |data|
        HourlyWeather.new(data)
      end
    end
  end
end
