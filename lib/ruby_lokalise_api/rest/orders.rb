# frozen_string_literal: true

module RubyLokaliseApi
  class Client
    # Returns all orders for the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-list-all-orders-get
    # @return [RubyLokaliseApi::Collection::Order<RubyLokaliseApi::Resources::Order>]
    # @param team_id [String]
    # @param params [Hash]
    def orders(team_id, params = {})
      c_r RubyLokaliseApi::Collections::Order, :all, team_id, params
    end

    # Returns a single order for the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-retrieve-an-order-get
    # @return [RubyLokaliseApi::Resources::Order]
    # @param team_id [String]
    # @param order_id [String, Integer]
    def order(team_id, order_id)
      c_r RubyLokaliseApi::Resources::Order, :find, [team_id, order_id]
    end

    # Creates an order for the given team
    #
    # @see https://lokalise.co/api2docs/curl/#transition-create-an-order-post
    # @return [RubyLokaliseApi::Resources::Order]
    # @param team_id [String]
    # @param params [Hash]
    def create_order(team_id, params)
      c_r RubyLokaliseApi::Resources::Order, :create, team_id, params
    end
  end
end
