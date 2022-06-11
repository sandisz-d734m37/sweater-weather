class Location
  attr_reader :query, :country, :state, :county, :city, :lat, :lon

  def initialize(data)
    @query = data[:results][0][:providedLocation][:location]
    @country = data[:results][0][:locations][0][:adminArea1]
    @state = data[:results][0][:locations][0][:adminArea3]
    @county = data[:results][0][:locations][0][:adminArea4]
    @city = data[:results][0][:locations][0][:adminArea5]
    @lat = data[:results][0][:locations][0][:displayLatLng][:lat]
    @lon = data[:results][0][:locations][0][:displayLatLng][:lng]
  end
end
