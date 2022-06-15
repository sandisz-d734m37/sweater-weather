class ErrorSerializer
  include JSONAPI::Serializer

  class << self
    def error_with_status(error_status)
      error_hash = {
        api_key: invalid_api_key,
        credentials: invalid_credentials,
        user_exists: user_already_exists,
        bad_registration: registration_bad_request
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

    def user_already_exists
      {
        data: {
          error_code: 409,
          type: "error",
          error_mesage: "Conflict: user already exists"
        }
      }
    end

    def registration_bad_request
      {
        data: {
          error_code: 400,
          type: "error",
          error_mesage: "Bad request: all fields must be populated and passwords must match"
        }
      }
    end
  end
end
