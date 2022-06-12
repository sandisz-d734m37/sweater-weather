require "rails_helper"

describe "Hourly Weather PORO" do
  before do
    weather_attr = JSON.parse(File.read('spec/fixtures/dc_weather.json'), symbolize_names: true)
    @hourly_weather = weather_attr[:hourly][0..7].map do |data|
      HourlyWeather.new(data)
    end
  end

  it "exists and has attributes" do
    expect(@hourly_weather.count).to eq(8)
    expect(@hourly_weather[0]).to be_an(HourlyWeather)
    expect(@hourly_weather[0].id).to eq(nil)

    expect(@hourly_weather[0].time).to eq("01:00:00 UTC")
    expect(@hourly_weather[0].temperature).to eq(67.6)
    expect(@hourly_weather[0].conditions).to eq("broken clouds")
    expect(@hourly_weather[0].icon).to eq("04n")
  end
end
