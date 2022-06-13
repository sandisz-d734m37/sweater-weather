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
          total_books_found: if book_list.class == String
            0
          else
            book_list[0].total_results
          end,
          books: if book_list.class == String
            book_list
          else
            book_list.map do |book|
              {
                isbn: book.isbn,
                title: book.title,
                publisher: book.publisher
              }
            end
          end
        }
      }
    }
  end
end
