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
    expect(image_data[:value][0][:contentUrl]).to eq("https://lovingcities.schottfoundation.org/wp-content/uploads/2018/01/profile-denver.jpg")
    expect(image_data[:value][0][:hostPageDisplayUrl]).to be_a(String)
    expect(image_data[:value][0][:hostPageDisplayUrl]).to eq("https://lovingcities.schottfoundation.org/cities/denver-co")
    expect(image_data[:value][0][:hostPageFavIconUrl]).to be_a(String)
    expect(image_data[:value][0][:hostPageFavIconUrl]).to eq("https://www.bing.com/th?id=ODF.xluPUAU6PNgXuUquHZGAuA&pid=Api")
  end
end
