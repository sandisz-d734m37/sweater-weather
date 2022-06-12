require "rails_helper"

describe "Current Weather PORO" do
  before do
    weather_attr = JSON.parse(File.read('spec/fixtures/dc_weather.json'), symbolize_names: true)
    @current_weather = CurrentWeather.new(weather_attr[:current])
  end

  it "exists and has readable attributes" do
    expect(@current_weather.id).to eq(nil)

    expect(@current_weather.datetime).to eq("06/12/22 at 01:24:38 UTC")
    expect(@current_weather.sunrise).to eq("06/11/22 at 09:42:24 UTC")
    expect(@current_weather.sunset).to eq("06/12/22 at 00:33:17 UTC")
    expect(@current_weather.temperature).to eq(67.6)
    expect(@current_weather.feels_like).to eq(67.91)
    expect(@current_weather.humidity).to eq(82)
    expect(@current_weather.uvi).to eq(0)
    expect(@current_weather.visibility).to eq(10000)
    expect(@current_weather.conditions).to eq("broken clouds")
    expect(@current_weather.icon).to eq("04n")
  end
end
