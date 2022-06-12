require "rails_helper"

describe WeatherFacade do
  before do
    @current_weather = WeatherFacade.get_current_weather(39.738453, -104.984853)
    @daily_weather = WeatherFacade.get_daily_weather(39.738453, -104.984853)
    @hourly_weather = WeatherFacade.get_hourly_weather(39.738453, -104.984853)
  end

  it "gets all weather" do
    expect(@current_weather).to be_a(CurrentWeather)
    expect(@daily_weather).to be_an(Array)
    expect(@daily_weather[0]).to be_a(DailyWeather)
    expect(@hourly_weather).to be_an(Array)
    expect(@hourly_weather[0]).to be_an(HourlyWeather)
  end
end
