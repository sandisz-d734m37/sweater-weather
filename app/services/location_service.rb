class LocationService
  class << self
    def get_location(query)
      response = conn.get("/geocoding/v1/address?key=#{api_key}&location=#{query}")

      get_json(response)
    end
    
    def conn
      Faraday.new("http://www.mapquestapi.com")
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.api_key
    ENV["MAPQUEST_API_KEY"]
  end

end
