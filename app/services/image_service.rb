class ImageService
  class << self
    def conn
      Faraday.new(
        url: "https://api.bing.microsoft.com",
        headers: {'Ocp-Apim-Subscription-Key' => ENV['BING_API_KEY']}
      )
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_background_image_data(query)
      response = conn.get("/v7.0/images/search?q=#{query}&count=1")
      get_json(response)
    end
  end
end
