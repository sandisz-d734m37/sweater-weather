class RouteFacade
  class << self
    def get_route(start_loc, end_loc)
      route_data = RouteService.get_route_data(start_loc, end_loc)
      Route.new(route_data)
    end
  end
end
