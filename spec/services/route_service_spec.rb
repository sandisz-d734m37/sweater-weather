require "rails_helper"

describe RouteService do
  it "gets route data", :vcr do
    route_data = RouteService.get_route_data("denver,co", "cedaredge,co")

    expect(route_data).to be_a(Hash)
    expect(route_data).to have_key(:route)
    expect(route_data[:route]).to have_key(:locations)
    expect(route_data[:route][:locations]).to be_an(Array)
    expect(route_data[:route][:locations][0]).to have_key(:adminArea5)
    expect(route_data[:route][:locations][0][:adminArea5]).to eq("Denver")
    expect(route_data[:route][:locations][-1][:adminArea5]).to eq("Cedaredge")
    expect(route_data[:route][:locations][0]).to have_key(:adminArea3)
    expect(route_data[:route][:locations][0][:adminArea3]).to eq("CO")
    expect(route_data[:route][:locations][-1][:adminArea3]).to eq("CO")
    expect(route_data[:route][:locations][0]).to have_key(:latLng)
    expect(route_data[:route][:locations][0][:latLng]).to have_key(:lat)
    expect(route_data[:route][:locations][0][:latLng]).to have_key(:lng)
    expect(route_data[:route]).to have_key(:formattedTime)
  end
end
