module RequestSpecHelper
    # Parse JSON response to ruby hash
    def json
      res = JSON.parse(response.body)

      return res

    end


  module JwtHelpers
    def token_headers(user)
      token = JWT.encode_token({user_id: user.id})
      {
        'Authorization': "Bearer #{token}"
      }
    end
  end

end
