# frozen_string_literal: true

module Lokalise
  module Resources
    class Order < Base
      ID_KEY = 'order_id'
      supports [:reload_data, '', :find]

      class << self
        def endpoint(team_id, order_id = nil)
          path_from teams: team_id,
                    orders: order_id
        end
      end
    end
  end
end
