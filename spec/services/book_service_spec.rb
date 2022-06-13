require "rails_helper"

describe BookService do
  it "gets book data with a search and limit query", :vcr do
    book_data = BookService.get_book_data("denver, co", 3)

    expect(book_data).to be_a(Hash)
    expect(book_data).to have_key(:numfound)
    expect(book_data[:numfound]).to be_an(Integer)
    expect(book_data).to have_key(:docs)
    expect(book_data[:docs]).to be_an(Array)
    expect(book_data[:docs].length).to eq(3)
    expect(book_data[:docs][0]).to have_key(:isbn)
    expect(book_data[:docs][0]).to have_key(:title)
    expect(book_data[:docs][0]).to have_key(:publisher)
  end
end
