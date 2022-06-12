require "rails_helper"

describe ImageService do
  it "gets image data" do
    image_data = ImageService.get_background_image_data("denver,co")

    expect(image_data).to be_a(Hash)
    expect(image_data).to have_key(:value)
    expect(image_data[:value]).to be_an(Array)
    expect(image_data[:value]).to be_an(Array)
    expect(image_data[:value].length).to eq(1)
    expect(image_data[:value][:contentUrl]).to be_a(String)
    expect(image_data[:value][:hostPageDisplayUrl]).to be_a(String)
    expect(image_data[:value][:hostPageFavIconUrl]).to be_a(String)
  end
end
