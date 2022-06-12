class Image
  attr_reader :location, :image_url, :credit

  def initialize(data, location)
    @location = location
    @image_url = data[:contentUrl]
    @credit = {
      source: data[:hostPageDisplayUrl],
      author: data[:hostPageDomainFriendlyName],
      logo: data[:hostPageFavIconUrl]
    }
  end
end
