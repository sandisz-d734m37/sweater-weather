class RouteService < LocationService
  class << self
    def get_route_data(start_loc, end_loc)
      response = conn.get("/directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{start_loc}&to=#{end_loc}")

      get_json(response)
    end
  end
end
