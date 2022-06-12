class LocationFacade
  class << self
    def get_location(query)
      location_data = LocationService.get_location(query)
      Location.new(location_data)
    end
  end
end
