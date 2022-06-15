require "rails_helper"

describe RouteFacade do
  before do
    VCR.insert_cassette("gets_route_data")
    @route = RouteFacade.get_route("denver,co", "cedaredge,co")
  end

  after do
    VCR.eject_cassette
  end

  it "creates a route PORO" do
    expect(@route).to be_a(Route)
    expect(@route.start_city).to eq("Denver, CO")
    expect(@route.start_lat).to eq(39.738453)
    expect(@route.start_lon).to eq(-104.984853)
    expect(@route.end_city).to eq("Cedaredge, CO")
    expect(@route.end_lat).to eq(38.900738)
    expect(@route.end_lon).to eq(-107.923767)
    expect(@route.travel_time).to eq("04:37:01")
  end

  describe "route is too long" do
    before do
      VCR.eject_cassette
      @route = RouteFacade.get_route("denver,co", "brussels")
    end

    it "returns a string" do
      expect(@route).to be_a(String)
      expect(@route).to eq("Trip data cannot be calculated.")
    end
  end
end
