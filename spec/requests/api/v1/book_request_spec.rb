require "rails_helper"

describe "Book request" do
  before do
    get "/api/v1/book-search?location=denver,co&quantity=3"

    @book_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "responds successfully", :vcr do
    expect(response).to be_successful
    expect(@book_response).to be_a(Hash)
    expect(@book_response[:data]).to be_a(Hash)
    expect(@book_response[:data][:id]).to eq(nil)
  end
end
