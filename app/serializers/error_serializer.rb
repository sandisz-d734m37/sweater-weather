class ErrorSerializer
  include JSONAPI::Serializer

  class << self
    def error_with_code(error_code)
      code_hash = {
        401 => invalid_api_key
      }

      code_hash[error_code]
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
  end
end
