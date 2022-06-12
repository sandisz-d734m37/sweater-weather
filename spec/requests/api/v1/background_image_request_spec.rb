require "rails_helper"

describe "Background Image request" do
  before do
    get "/api/v1/backgrounds?location=denver,co"

    @image_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "responds successfully", :vcr do
    expect(response).to be_successful
    expect(@image_response).to be_a(Hash)
    expect(@image_response[:data][:id]).to eq(nil)
    expect(@image_response[:data][:type]).to eq("image")
    expect(@image_response[:data]).to have_key(:attributes)
    expect(@image_response[:data][:attributes]).to be_a(Hash)
    expect(@image_response[:data][:attributes]).to have_key(:image)
  end
end
