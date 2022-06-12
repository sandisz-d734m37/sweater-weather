require "rails_helper"

describe "Current Weather PORO" do
  before do
    weather_attr = JSON.parse(File.read('spec/fixtures/dc_weather.json'), symbolize_names: true)
    @daily_weather = weather_attr[:daily][0..4].map do |data|
      DailyWeather.new(data)
    end
  end

  it "exists and has readable attributes" do
    expect(@daily_weather.count).to eq(5)
    expect(@daily_weather[0].id).to eq(nil)

    expect(@daily_weather[0].date).to eq("06/11/22")
    expect(@daily_weather[0].sunrise).to eq("06/11/22 at 09:42:24 UTC")
    expect(@daily_weather[0].sunset).to eq("06/12/22 at 00:33:17 UTC")
    expect(@daily_weather[0].max_temp).to eq(74.97)
    expect(@daily_weather[0].min_temp).to eq(61.75)
    expect(@daily_weather[0].conditions).to eq("moderate rain")
    expect(@daily_weather[0].icon).to eq("10d")
  end
end
