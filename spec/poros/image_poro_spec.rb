require "rails_helper"

describe Image do
  before do
    image_attr = JSON.parse(File.read('spec/fixtures/denver_image_search.json'), symbolize_names: true)
    @image = image_attr[:value].map do |data|
      Image.new(data, "Denver, CO")
    end
  end

  it "exists and has attributes" do
    expect(@image).to be_an(Array)
    expect(@image[0]).to be_an(Image)
    expect(@image[0].location).to eq("Denver, CO")
    expect(@image[0].image_url).to eq("https://lovingcities.schottfoundation.org/wp-content/uploads/2018/01/profile-denver.jpg")
    expect(@image[0].credit).to eq({source: "https://lovingcities.schottfoundation.org/cities/denver-co", author: nil, logo: "https://www.bing.com/th?id=ODF.xluPUAU6PNgXuUquHZGAuA&pid=Api"})
  end
end
