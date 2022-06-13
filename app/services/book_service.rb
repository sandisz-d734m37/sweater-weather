class BookService
  class << self
    def conn
      Faraday.new("http://openlibrary.org")
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_book_data(query, range)
      response = conn.get("/search.json?q=#{query}&limit=#{range}")

      get_json(response)
    end
  end
end
