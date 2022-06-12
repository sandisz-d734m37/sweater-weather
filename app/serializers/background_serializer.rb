class BackgroundSerializer
  include JSONAPI::Serializer

  def self.background(image_poro)
    {
      data: {
        id: nil,
        type: "image",
        attributes: {
          image: {
            location: image_poro.location,
            image_url: image_poro.image_url,
            credit: image_poro.credit
          }
        }
      }
    }
  end
end
