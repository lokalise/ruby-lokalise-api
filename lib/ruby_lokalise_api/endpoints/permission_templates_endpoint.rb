# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class PermissionTemplatesEndpoint < MainEndpoint
      private

      def base_query(team_id)
        {
          teams: [team_id, :roles]
        }
      end
    end
  end
end
