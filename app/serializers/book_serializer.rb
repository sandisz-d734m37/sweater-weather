class BookSerializer
  include JSONAPI::Serializer

  def self.books(current_weather, book_list, query)
    {
      data: {
        id: nil,
        type: "books",
        attributes: {
          destination: query,
          forecast: {
            summary: current_weather.conditions,
            temperature: current_weather.temperature
          },
          total_books_found: book_list[0].total_results,
          books: book_list.map do |book|
            {
              isbn: book.isbn,
              title: book.title,
              publisher: book.publisher
            }
          end
        }
      }
    }
  end
end
