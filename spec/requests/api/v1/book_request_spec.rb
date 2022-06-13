require "rails_helper"

describe "Book request" do
  before do
    @current_weather = JSON.parse(File.read('spec/fixtures/denver_weather.json'), symbolize_names: true)

    allow(WeatherService).to receive(:get_weather_data).and_return(@current_weather)

    VCR.insert_cassette("Book_request/responds_successfully")

    get "/api/v1/book-search?location=denver,co&quantity=3"

    @book_response = JSON.parse(response.body, symbolize_names: true)
  end

  after do
    VCR.eject_cassette
  end

  it "responds successfully", :vcr do
    expect(response).to be_successful
    expect(@book_response).to be_a(Hash)
    expect(@book_response[:data]).to be_a(Hash)
    expect(@book_response[:data][:id]).to eq(nil)
    expect(@book_response[:data][:attributes]).to have_key(:destination)
    expect(@book_response[:data][:attributes][:destination]).to eq("denver,co")
  end

  it "responds with weather data" do
    expect(@book_response[:data][:attributes]).to have_key(:forecast)
    expect(@book_response[:data][:attributes][:forecast]).to be_a(Hash)
    expect(@book_response[:data][:attributes][:forecast]).to have_key(:summary)
    expect(@book_response[:data][:attributes][:forecast]).to have_key(:temperature)
  end

  it "responds with book data within the quantity range" do
    expect(@book_response[:data][:attributes]).to have_key(:total_books_found)
    expect(@book_response[:data][:attributes][:total_books_found]).to be_an(Integer)
    expect(@book_response[:data][:attributes]).to have_key(:books)
    expect(@book_response[:data][:attributes][:books]).to be_an(Array)
    expect(@book_response[:data][:attributes][:books].length).to eq(3)
    expect(@book_response[:data][:attributes][:books][0]).to have_key(:isbn)
    expect(@book_response[:data][:attributes][:books][0][:isbn]).to be_an(Array)
    expect(@book_response[:data][:attributes][:books][0]).to have_key(:title)
    expect(@book_response[:data][:attributes][:books][0][:title]).to be_a(String)
    expect(@book_response[:data][:attributes][:books][0]).to have_key(:publisher)
    expect(@book_response[:data][:attributes][:books][0][:publisher]).to be_an(Array)
  end

  it "does not return unnecessary weather data" do
    expect(@book_response[:data][:attributes][:forecast].length).to eq(2)
    expect(@book_response[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
  end

  it "does not return unecessary book data" do
    expect(@book_response[:data][:attributes][:books][0].length).to eq(3)
    expect(@book_response[:data][:attributes][:books][0].keys).to eq([:isbn, :title, :publisher])
  end
end

describe "book request edge case" do
  before do
    get "/api/v1/book-search?location=denver,co&quantity=0"

    @book_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "returns a string and fails gracefully" do
    expect(@book_response[:data][:attributes][:books]).to eq("No books to display")
  end
end
