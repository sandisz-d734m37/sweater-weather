require "rails_helper"

describe LocationFacade do
  before do
    VCR.insert_cassette("gets_a_location_with_a_string")
    @location = LocationFacade.get_location("Denver,CO")
  end

  after do
    VCR.eject_cassette
  end

  it "creates a PORO with proper attributes" do
    expect(@location).to be_a(Location)
    expect(@location.query).to eq("Denver,CO")
    expect(@location.country).to eq("US")
    expect(@location.state).to eq("CO")
    expect(@location.county).to eq("Denver County")
    expect(@location.city).to eq("Denver")
    expect(@location.lat).to eq(39.738453)
    expect(@location.lon).to eq(-104.984853)
  end
end
