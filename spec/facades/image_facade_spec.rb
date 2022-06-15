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
    expect(@image.image_url).to eq("https://meetingsource.com/wp-content/uploads/2017/01/Denver_345958679.jpg")
    expect(@image.credit).to be_a(Hash)
    expect(@image.credit[:source]).to eq("https://meetingsource.com/listing/denver")
    expect(@image.credit[:author]).to eq(nil)
    expect(@image.credit[:logo]).to eq(nil)
  end

  it "create's an image PORO with all attrs", :vcr do
    VCR.eject_cassette

    @image = ImageFacade.get_background_image("new zealand")

    expect(@image).to be_an(Image)
    expect(@image.location).to eq("new zealand")
    expect(@image.image_url).to eq("https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/LakeWakatipuNewZealand.jpg?crop=0%2C25%2C4000%2C2200&wid=4000&hei=2200&scl=1.0")
    expect(@image.credit).to be_a(Hash)
    expect(@image.credit[:source]).to eq("https://www.nature.org/en-us/about-us/where-we-work/asia-pacific/new-zealand")
    expect(@image.credit[:author]).to eq("The Nature Conservancy")
    expect(@image.credit[:logo]).to eq("https://www.bing.com/th?id=ODF.JMnqBCS24HhK16QNwxfU_w&pid=Api")
  end
end
