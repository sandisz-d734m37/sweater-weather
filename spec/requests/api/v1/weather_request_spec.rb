require "rails_helper"

describe "Weather request" do
  before do
    get "/api/v1/forecast?location=denver,co"

    @weather_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "responds successfully" do
    expect(response).to be_successful
    expect(@weather_response[:data][:id]).to eq(nil)
    expect(@weather_response[:data][:type]).to eq("forecast")
    expect(@weather_response[:data][:attributes]).to be_a(Hash)
  end

  it "returns all weather data in single response" do
    expect(@weather_response[:data][:attributes]).to have_key(:current_weather)
    expect(@weather_response[:data][:attributes]).to have_key(:daily_weather)
    expect(@weather_response[:data][:attributes]).to have_key(:hourly_weather)
  end

  it "returns the current weather data" do
    expect(@weather_response[:data][:attributes][:current_weather]).to be_a(Hash)

    expect(@weather_response[:data][:attributes][:current_weather][:datetime]).to be_a(String)
    expect(@weather_response[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
    expect(@weather_response[:data][:attributes][:current_weather][:sunset]).to be_a(String)
    expect(@weather_response[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:current_weather][:humidity]).to be_an(Integer)
    expect(@weather_response[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:current_weather][:visibility]).to be_an(Integer)
    expect(@weather_response[:data][:attributes][:current_weather][:conditions]).to be_a(String)
    expect(@weather_response[:data][:attributes][:current_weather][:icon]).to be_a(String)
  end

  it "returns an array of daily weather data" do
    expect(@weather_response[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(@weather_response[:data][:attributes][:daily_weather].length).to eq(5)
    expect(@weather_response[:data][:attributes][:daily_weather][0]).to be_a(Hash)

    expect(@weather_response[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
    expect(@weather_response[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
    expect(@weather_response[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
    expect(@weather_response[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)
  end

  it "returns an array of hourly weather data" do
    expect(@weather_response[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(@weather_response[:data][:attributes][:hourly_weather].length).to eq(8)
    expect(@weather_response[:data][:attributes][:hourly_weather][0]).to be_a(Hash)

    expect(@weather_response[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
    expect(@weather_response[:data][:attributes][:hourly_weather][0][:temperature]).to be_a(Float)
    expect(@weather_response[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
    expect(@weather_response[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
  end
end
