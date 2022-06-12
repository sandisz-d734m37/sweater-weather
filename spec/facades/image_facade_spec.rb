require "rails_helper"

describe ImageFacade do
  before do
    VCR.insert_cassette("gets_image_data")
    @image = ImageFacade.get_background_image("denver,co")
  end

  after do
    VCR.eject_cassette
  end

  it "create's an image PORO" do
    expect(@image).to be_an(Image)
    expect(@image.location).to eq("denver,co")
    expect(@image.image_url).to eq("https://lovingcities.schottfoundation.org/wp-content/uploads/2018/01/profile-denver.jpg")
    expect(@image.credit).to be_a(Hash)
    expect(@image.credit[:source]).to eq("https://lovingcities.schottfoundation.org/cities/denver-co")
    expect(@image.credit[:author]).to eq(nil)
    expect(@image.credit[:logo]).to eq("https://www.bing.com/th?id=ODF.xluPUAU6PNgXuUquHZGAuA&pid=Api")
  end
end
