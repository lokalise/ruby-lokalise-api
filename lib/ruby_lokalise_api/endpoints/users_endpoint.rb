# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class UsersEndpoint < MainEndpoint
      private

      def base_query(user_id)
        {
          users: user_id
        }
      end
    end
  end
end
