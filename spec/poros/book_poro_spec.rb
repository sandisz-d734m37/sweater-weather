require "rails_helper"

describe Book do
  before do
    book_attr = JSON.parse(File.read('spec/fixtures/denver_co_3_books.json'), symbolize_names: true)
    @books = book_attr[:docs].map do |book_data|
      Book.new(book_data)
    end
  end

  it "exists and has attributes" do
    expect(@books[0]).to be_a(Book)
    expect(@books.length).to eq(3)
    expect(@books[0].isbn).to eq(["9780762507849", "0762507845"])
    expect(@books[0].title).to eq("Denver, Co")
    expect(@books[0].publisher).to eq(["Universal Map Enterprises"])
  end
end
