# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TeamUserGroupsEndpoint < MainEndpoint
      private

      def base_query(team_id, group_id = nil, *actions)
        {
          teams: team_id,
          groups: [group_id, actions]
        }
      end
    end
  end
end
