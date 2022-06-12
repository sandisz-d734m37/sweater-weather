class LocationService
  class << self
    def conn
      Faraday.new("http://www.mapquestapi.com")
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_location(query)
      response = conn.get("/geocoding/v1/address?key=#{api_key}&location=#{query}")

      get_json(response)
    end
  end

  private

  def self.api_key
    ENV["MAPQUEST_API_KEY"]
  end

end
