require "rails_helper"

describe WeatherService do
  it "gets weather data using latitude & longitude", :vcr do
    weather_data = WeatherService.get_weather(39.738453, -104.984853)

    expect(weather_data).to be_a(Hash)
    expect(weather_data).to have_key(:current)
    expect(weather_data).to have_key(:hourly)
    expect(weather_data).to have_key(:daily)
    expect(weather_data[:current][:temp]).to eq("Denver,CO")
    expect(weather_data[:hourly][0][:temp][:max]).to eq("Denver")
    expect(weather_data[:daily][0][:temp]).to eq("Denver")
  end
end
