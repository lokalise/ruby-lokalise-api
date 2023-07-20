# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TeamUserBillingDetailsEndpoint < MainEndpoint
      private

      def base_query(team_id)
        {
          teams: [team_id, :billing_details]
        }
      end
    end
  end
end
