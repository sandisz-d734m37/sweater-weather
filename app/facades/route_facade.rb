class RouteFacade
  class << self
    def get_route(start_loc, end_loc)
      route_data = RouteService.get_route_data(start_loc, end_loc)

      if route_data[:info][:statuscode] == 0
        Route.new(route_data)
      else
        binding.pry
        "Trip data cannot be calculated."
      end
    end
  end
end
