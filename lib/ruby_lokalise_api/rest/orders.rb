# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Orders
      # Returns all orders for the given team
      #
      # @see https://developers.lokalise.com/reference/list-all-orders
      # @return [RubyLokaliseApi::Collection::Order<RubyLokaliseApi::Resources::Order>]
      # @param team_id [String]
      # @param params [Hash]
      def orders(team_id, params = {})
        c_r RubyLokaliseApi::Collections::Order, :all, team_id, params
      end

      # Returns a single order for the given team
      #
      # @see https://developers.lokalise.com/reference/retrieve-an-order
      # @return [RubyLokaliseApi::Resources::Order]
      # @param team_id [String]
      # @param order_id [String, Integer]
      def order(team_id, order_id)
        c_r RubyLokaliseApi::Resources::Order, :find, [team_id, order_id]
      end

      # Creates an order for the given team
      #
      # @see https://developers.lokalise.com/reference/create-an-order
      # @return [RubyLokaliseApi::Resources::Order]
      # @param team_id [String]
      # @param params [Hash]
      def create_order(team_id, params)
        c_r RubyLokaliseApi::Resources::Order, :create, team_id, params
      end
    end
  end
end
