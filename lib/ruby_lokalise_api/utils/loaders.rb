# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      def endpoint(name:, client: self, params: {})
        klass = RubyLokaliseApi.const_get "Endpoints::#{name}Endpoint"
        klass.new client, params
      end

      def resource(name, data)
        klass = RubyLokaliseApi.const_get "Resources::#{name}"
        klass.new data
      end

      def collection(name, data)
        klass = RubyLokaliseApi.const_get "Collections::#{name}"
        klass.new data
      end
    end
  end
end
