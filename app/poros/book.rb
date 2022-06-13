class Book
  attr_reader :isbn, :title, :publisher, :total_results

  def initialize(data, total_results)
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
    @total_results = total_results
  end
end
