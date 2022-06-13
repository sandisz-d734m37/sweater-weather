class BookFacade
  class << self
    def get_books(query, range)
      all_book_data = BookService.get_book_data(query, range)
      
      unless all_book_data[:docs].empty?
        all_book_data[:docs].map do |book_data|
          Book.new(book_data, all_book_data[:numFound])
        end
      else
        "No books to display"
      end
    end
  end
end
