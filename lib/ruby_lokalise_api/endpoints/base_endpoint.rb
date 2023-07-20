# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class BaseEndpoint
      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Request

      attr_reader :client, :req_params, :uri

      BASE_URL = ''
      PARTIAL_URI_TEMPLATE = '{/segments*}'

      def initialize(client, params = {})
        @query_params = params[:query].to_array
        @client = client
        @req_params = params[:req]
        @uri = nil
      end

      def reinitialize(query_params: nil, req_params: {})
        @query_params = query_params || @query_params
        @req_params = req_params || @req_params
        @uri = partial_uri(base_query(*@query_params))

        self
      end

      def base_url
        self.class.const_get(:BASE_URL)
      end

      def full_uri
        base_url + uri
      end

      private

      HTTP_METHODS_REGEXP = /\Ado_(get|post|put|delete|patch)\z/.freeze

      def respond_to_missing?(method, _include_all)
        return true if HTTP_METHODS_REGEXP.match?(method.to_s)

        super
      end

      def method_missing(method, *_args)
        if method.to_s =~ HTTP_METHODS_REGEXP
          send Regexp.last_match(1), self
        else
          super
        end
      end

      def base_query(*_args); end

      def partial_uri(*_args)
        Addressable::Template.new partial_uri_template
      end

      def partial_uri_template
        self.class.const_get(:PARTIAL_URI_TEMPLATE)
      end
    end
  end
end
