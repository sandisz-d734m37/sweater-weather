class Route
  attr_reader :start_city,
              :start_lat,
              :start_lon,
              :end_city,
              :end_lat,
              :end_lon,
              :travel_time

  def initialize(route_data)
    @start_city = "#{route_data[:route][:locations][0][:adminArea5]}, #{route_data[:route][:locations][0][:adminArea3]}"
    @start_lat = route_data[:route][:locations][0][:latLng][:lat]
    @start_lon = route_data[:route][:locations][0][:latLng][:lng]
    @end_city = "#{route_data[:route][:locations][-1][:adminArea5]}, #{route_data[:route][:locations][-1][:adminArea3]}"
    @end_lat = route_data[:route][:locations][-1][:latLng][:lat]
    @end_lon = route_data[:route][:locations][-1][:latLng][:lng]
    @travel_time = route_data[:route][:formattedTime]
  end
end
