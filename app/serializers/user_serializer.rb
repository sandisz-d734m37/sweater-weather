class UserSerializer
  include JSONAPI::Serializer

  def self.register(user)
    {
      data: {
        id: user.id,
        type: "user",
        attributes: {
          email: user.email,
          api_key: user.api_key
        }
      }
    }
  end
end
