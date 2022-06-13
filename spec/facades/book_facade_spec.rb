require "rails_helper"

describe BookFacade do
  before do
    VCR.insert_cassette("gets_book_data_with_a_search_and_limit_query")

    @books = BookFacade.get_books("denver,co", 3)
  end

  after do
    VCR.eject_cassette
  end

  it "creates Book POROS" do
    expect(@books).to be_an(Array)
    expect(@books.length).to eq(3)
    expect(@books[0]).to be_a(Book)
    expect(@books[0].isbn).to eq(["9780762507849","0762507845"])
    expect(@books[0].title).to eq("Denver, Co")
    expect(@books[0].publisher).to eq(["Universal Map Enterprises"])
  end
end
