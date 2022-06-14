require "rails_helper"

describe Route do
  before do
    route_attr = JSON.parse(File.read('spec/fixtures/route.json'), symbolize_names: true)
    @route = Route.new(route_attr)
  end

  it "exists and had readable attributes" do
    expect(@route).to be_a(Route)
    expect(@route.start_city).to eq("Denver, CO")
    expect(@route.start_lat).to eq("39.738453")
    expect(@route.start_lon).to eq("-104.984853")
    expect(@route.end_city).to eq("Cedaredge, CO")
    expect(@route.end_lat).to eq("38.900738")
    expect(@route.end_lon).to eq("-107.923767")
    expect(@route.travel_time).to eq("04:37:01")
  end
end
