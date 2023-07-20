# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TeamUsersEndpoint < MainEndpoint
      private

      def base_query(team_id, user_id = nil)
        {
          teams: team_id,
          users: user_id
        }
      end
    end
  end
end
