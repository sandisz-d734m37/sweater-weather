require "rails_helper"

describe WeatherService do
  it "gets weather data using latitude & longitude" do
    weather_data = WeatherService.get_weather_data(39.738453, -104.984853)

    expect(weather_data).to be_a(Hash)
    expect(weather_data).to have_key(:current)
    expect(weather_data).to have_key(:hourly)
    expect(weather_data).to have_key(:daily)
  end
end
