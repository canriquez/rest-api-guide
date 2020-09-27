module Request
    module JsonHelpers
      def json_response
        @json_response ||= JSON.parse(response.body, symbolize_names: true)
      end
    end


    module AuthHelpers
        def auth_headers(user)
          #token = Knock::AuthToken.new(payload: { sub: user.id }).token
          #token = JWT.encode({user_id: user.id})
          token = JWT.encode({user_id: user.id}, 'elxhongodelsolda2')
          {
            'Authorization': "Bearer #{token}"
          }
        end
      end
end