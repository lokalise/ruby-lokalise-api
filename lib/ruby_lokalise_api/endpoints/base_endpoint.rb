# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class BaseEndpoint
      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Request

      attr_reader :client, :req_params, :uri

      BASE_URL = ''
      PARTIAL_URI_TEMPLATE = '{/segments*}'
      HTTP_METHODS = %i[get post put delete patch].freeze

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

      # Creates methods like `do_post`, `do_get` that proxy calls to the
      # corresponding methods in the `Request` module
      HTTP_METHODS.each do |method_postfix|
        define_method :"do_#{method_postfix}" do
          send method_postfix, self
        end
      end

      private

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
