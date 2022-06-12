require "rails_helper"

describe "Weather PORO" do
  before do
    weather_attr = JSON.parse(File.read('spec/fixtures/dc_weather.json'), symbolize_names: true)
    @all_weather = weather_attr[:list].map do |data|
      Weather.new(data)
    end
  end

  it "exists and has readable attributes" do
    binding.pry
  end
end
