require "rails_helper"

describe "Background Image request" do
  before do
    VCR.insert_cassette("Background_Image_request/responds_successfully")
    get "/api/v1/backgrounds?location=denver,co"

    @image_response = JSON.parse(response.body, symbolize_names: true)
  end

  after do
    VCR.eject_cassette
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

  it "sends image data" do
    expect(@image_response[:data][:attributes][:image]).to be_a(Hash)
    expect(@image_response[:data][:attributes][:image][:location]).to eq("denver,co")
    expect(@image_response[:data][:attributes][:image][:image_url]).to eq("https://lovingcities.schottfoundation.org/wp-content/uploads/2018/01/profile-denver.jpg")
    expect(@image_response[:data][:attributes][:image][:credit]).to be_a(Hash)
    expect(@image_response[:data][:attributes][:image][:credit][:source]).to eq("https://lovingcities.schottfoundation.org/cities/denver-co")
    expect(@image_response[:data][:attributes][:image][:credit][:author]).to eq(nil)
    expect(@image_response[:data][:attributes][:image][:credit][:logo]).to eq("https://www.bing.com/th?id=ODF.xluPUAU6PNgXuUquHZGAuA&pid=Api")
  end
end
