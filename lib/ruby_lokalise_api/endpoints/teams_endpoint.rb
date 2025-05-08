# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TeamsEndpoint < MainEndpoint
      private

      def base_query(team_id = nil, *_args)
        {
          teams: [team_id]
        }
      end
    end
  end
end
