# frozen_string_literal: true

module Lokalise
  module OAuth2
    module Request
      include Lokalise::BaseRequest
      include Lokalise::OAuth2::Connection

      def post(path, params = {})
        respond_with connection.post(prepare(path), custom_dump(params))
      end

      private

      def respond_with(response)
        body = custom_load response.body
        status = response.status
        raise_on_error! status, body
        body
      end
    end
  end
end
