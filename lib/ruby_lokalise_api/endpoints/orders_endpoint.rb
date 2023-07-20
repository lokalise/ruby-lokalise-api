# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class OrdersEndpoint < MainEndpoint
      private

      def base_query(team_id, order_id = nil)
        {
          teams: team_id,
          orders: order_id
        }
      end
    end
  end
end
