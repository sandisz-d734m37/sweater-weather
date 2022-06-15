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

  end

  describe "within 8 hrs" do
    before do
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

    it "creates a trip" do
      road_trip = RoadTrip.find_by(user_id: @user.id)

      expect(road_trip).to be_a(RoadTrip)
    end

    it "responds correctly" do
      expect(response).to be_successful

      expect(@road_trip_data).to be_a(Hash)
      expect(@road_trip_data[:data]).to have_key(:id)
      expect(@road_trip_data[:data][:id]).to eq(nil)
      expect(@road_trip_data[:data]).to have_key(:type)
      expect(@road_trip_data[:data][:type]).to eq("roadtrip")
      expect(@road_trip_data[:data]).to have_key(:attributes)
      expect(@road_trip_data[:data][:attributes]).to be_a(Hash)
      expect(@road_trip_data[:data][:attributes]).to have_key(:start_city)
      expect(@road_trip_data[:data][:attributes]).to have_key(:end_city)
      expect(@road_trip_data[:data][:attributes]).to have_key(:travel_time)
      expect(@road_trip_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(@road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(@road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end
  end

  describe "over 8 hrs" do
    before do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        origin: "denver,co",
        destination: "new york,ny",
        api_key: @user.api_key
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      @road_trip_data = JSON.parse(response.body, symbolize_names: true)
    end
    it "responds correctly" do
      expect(response).to be_successful

      expect(@road_trip_data).to be_a(Hash)
      expect(@road_trip_data[:data]).to have_key(:id)
      expect(@road_trip_data[:data][:id]).to eq(nil)
      expect(@road_trip_data[:data]).to have_key(:type)
      expect(@road_trip_data[:data][:type]).to eq("roadtrip")
      expect(@road_trip_data[:data]).to have_key(:attributes)
      expect(@road_trip_data[:data][:attributes]).to be_a(Hash)
      expect(@road_trip_data[:data][:attributes]).to have_key(:start_city)
      expect(@road_trip_data[:data][:attributes][:start_city]).to eq("Denver, CO")
      expect(@road_trip_data[:data][:attributes]).to have_key(:end_city)
      expect(@road_trip_data[:data][:attributes][:end_city]).to eq("New York, NY")
      expect(@road_trip_data[:data][:attributes]).to have_key(:travel_time)
      expect(@road_trip_data[:data][:attributes][:travel_time]).to eq("26:07:39")
      expect(@road_trip_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(@road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(@road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end
  end

  describe "Road Trip: Impossible (ft. Tom Cruise)" do
    before do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        origin: "denver,co",
        destination: "brussels",
        api_key: @user.api_key
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      @road_trip_data = JSON.parse(response.body, symbolize_names: true)
    end

    it "fails gracefully" do
      expect(@road_trip_data).to be_a(Hash)
      expect(@road_trip_data[:data][:attributes][:start_city]).to eq("denver,co")
      expect(@road_trip_data[:data][:attributes][:end_city]).to eq("brussels")
      expect(@road_trip_data[:data][:attributes][:travel_time]).to eq("impossible")
      expect(@road_trip_data[:data][:attributes][:weather_at_eta]).to be_empty
    end
  end

  describe "error handling" do
    it "returns 401 error when no API key is provided" do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        origin: "denver,co",
        destination: "cedaredge,co"
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:data][:type]).to eq("error")
      expect(error_data[:data][:error_code]).to eq(401)
      expect(error_data[:data][:error_mesage]).to eq("Invalid API key")
    end

    it "returns 401 error when an invalid key is provided" do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        origin: "denver,co",
        api_key: "totally_not_valid"
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:data][:type]).to eq("error")
      expect(error_data[:data][:error_code]).to eq(401)
      expect(error_data[:data][:error_mesage]).to eq("Invalid API key")
    end

    it "returns impossible trip when no destination is given" do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        origin: "denver,co",
        api_key: @user.api_key
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      impossible_trip = JSON.parse(response.body, symbolize_names: true)

      expect(impossible_trip).to be_a(Hash)
      expect(impossible_trip[:data][:attributes][:start_city]).to eq("denver,co")
      expect(impossible_trip[:data][:attributes][:travel_time]).to eq("impossible")
      expect(impossible_trip[:data][:attributes][:weather_at_eta]).to be_empty
    end

    it "returns impossible trip when no origin is given" do
      road_trip_headers = {
        "Content-type": "application/json",
        "Accept": "application/json"
      }
      road_trip_body = {
        destination: "denver,co",
        api_key: @user.api_key
      }

      post "/api/v1/road_trip", headers: road_trip_headers, params: JSON.generate(road_trip_body)

      impossible_trip = JSON.parse(response.body, symbolize_names: true)

      expect(impossible_trip).to be_a(Hash)
      expect(impossible_trip[:data][:attributes][:end_city]).to eq("denver,co")
      expect(impossible_trip[:data][:attributes][:travel_time]).to eq("impossible")
      expect(impossible_trip[:data][:attributes][:weather_at_eta]).to be_empty
    end
  end
end
