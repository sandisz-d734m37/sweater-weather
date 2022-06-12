require "rails_helper"

describe LocationService do
  it "gets a location with a string" do
    location_data = LocationService.get_location("Denver,CO")

    expect(location_data).to be_a(Hash)
    expect(location_data).to have_key(:info)
    expect(location_data).to have_key(:results)
    expect(location_data[:results][0][:providedLocation][:location]).to eq("Denver,CO")
    expect(location_data[:results][0][:locations][0][:adminArea5]).to eq("Denver")
  end
end
