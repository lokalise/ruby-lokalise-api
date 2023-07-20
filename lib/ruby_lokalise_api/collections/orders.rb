# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Orders < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::OrdersEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Order
    end
  end
end
