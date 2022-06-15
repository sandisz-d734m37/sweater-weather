class ErrorSerializer
  include JSONAPI::Serializer

  class << self
    def error_with_status(error_status)
      error_hash = {
        api_key: invalid_api_key,
        credentials: invalid_credentials
      }

      error_hash[error_status]
    end

    def invalid_api_key
      {
        data: {
          error_code: 401,
          type: "error",
          error_mesage: "Invalid API key"
        }
      }
    end

    def invalid_credentials
      {
        data: {
          error_code: 401,
          type: "error",
          error_mesage: "Invalid log in credentials"
        }
      }
    end
  end
end
