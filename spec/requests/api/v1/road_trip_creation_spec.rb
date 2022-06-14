require "rails_helper"

describe "Road trip POST request" do
  before do
    user_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    user_body = {
      email: "user_1@firstuser.com",
      password: "user1password",
      password_confirmation: "user1password"
    }

    post "/api/v1/users", headers: user_headers, params: JSON.generate(user_body)
    @user = User.find_by(email: "user_1@firstuser.com")

    road_trip_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    road_trip_body = {
      origin: "denver,co",
      destination: "cedaredge,co",
      api_key: @user.api_key
    }

    post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

    @road_trip_data = JSON.parse(response.body, symbolize_names: true)
  end

  it "creates a road trip" do
    expect(response).to be_successful

    expect(@road_trip_data).to be_a(Hash)
    expect(@road_trip_data[:data]).to have_key(:id)
    expect(@road_trip_data[:data][:id]).to eq(nil)
    expect(@road_trip_data[:data]).to have_key(:type)
    expect(@road_trip_data[:data][:type]).to eq("roadtrip")
    expect(@road_trip_data[:data]).to have_key(:attributes)
    expect(@road_trip_data[:data][:attributes]).to be_a(Hash)
  end
end
