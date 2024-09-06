# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      # Instantiates an endpoint
      #
      # @param name [String] The name of the endpoint
      # @param client [Object] The client to associate with the endpoint (default: self)
      # @param params [Hash] Additional parameters for the endpoint
      # @return [Object] The instantiated endpoint
      def endpoint(name:, client: self, params: {})
        instantiate("Endpoints::#{name}Endpoint", client, params)
      end

      # Instantiates a resource
      #
      # @param name [String] The name of the resource
      # @param data [Hash] The data to initialize the resource with
      # @return [Object] The instantiated resource
      def resource(name, data)
        instantiate("Resources::#{name}", data)
      end

      # Instantiates a collection
      #
      # @param name [String] The name of the collection
      # @param data [Hash] The data to initialize the collection with
      # @return [Object] The instantiated collection
      def collection(name, data)
        instantiate("Collections::#{name}", data)
      end

      # Helper method to instantiate a class by constant name
      #
      # @param constant_path [String] The constant path for the class
      # @param args [Array] Arguments to initialize the class with
      # @return [Object] The instantiated class
      def instantiate(constant_path, *args)
        RubyLokaliseApi.const_get(constant_path).new(*args)
      end
    end
  end
end
