class ImageFacade
  class << self
    def get_background_image(query)
      image_data = ImageService.get_background_image_data(query)

      image = image_data[:value].map do |data|
        Image.new(data, query)
      end

      return image.first
    end
  end
end
