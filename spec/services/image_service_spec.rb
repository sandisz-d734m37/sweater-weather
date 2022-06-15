require "rails_helper"

describe ImageService do
  it "gets image data", :vcr do
    image_data = ImageService.get_background_image_data("denver,co")

    expect(image_data).to be_a(Hash)
    expect(image_data).to have_key(:value)
    expect(image_data[:value]).to be_an(Array)
    expect(image_data[:value]).to be_an(Array)
    expect(image_data[:value].length).to eq(1)
    expect(image_data[:value][0][:contentUrl]).to be_a(String)
    expect(image_data[:value][0][:contentUrl]).to eq("https://meetingsource.com/wp-content/uploads/2017/01/Denver_345958679.jpg")
    expect(image_data[:value][0][:hostPageDisplayUrl]).to be_a(String)
    expect(image_data[:value][0][:hostPageDisplayUrl]).to eq("https://meetingsource.com/listing/denver")
    expect(image_data[:value][0][:hostPageFavIconUrl]).to eq(nil)
  end
end
