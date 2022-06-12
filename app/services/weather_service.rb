class WeatherService
  class << self
    def conn
      Faraday.new("https://api.openweathermap.org")
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_weather_data(lat, lon)
      response = conn.get("/data/2.5/onecall?lat=#{lat}&lon=#{lon}&appid=#{api_key}&units=imperial")

      get_json(response)
    end
  end

  private

  def self.api_key
    ENV["WEATHER_API_KEY"]
  end

end
