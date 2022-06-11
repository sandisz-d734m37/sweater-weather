require "rails_helper"

describe "location Poro" do
  before do
    location_attr = JSON.parse(File.read('spec/fixtures/location.json'), symbolize_names: true)
    @location = Location.new(location_attr)
  end

  it "exists and has readable attributes" do
    expect(@location).to be_a(Location)
    expect(@location.query).to eq("Washington,DC")
    expect(@location.state).to eq("DC")
    expect(@location.city).to eq("Washington")
    expect(@location.county).to eq("District of Columbia")
    expect(@location.lat).to eq(38.892062)
    expect(@location.lon).to eq(-77.019912)
  end
end
