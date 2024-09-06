# frozen_string_literal: true

module RubyLokaliseApi
  # Module to setup connection using Faraday
  module Connection
    # Creates a new Faraday object with specified params
    #
    # @param endpoint [Object] the API endpoint
    # @param params [Hash] additional connection parameters
    # @return [Faraday::Connection] the Faraday connection object
    def connection(endpoint, params = {})
      Faraday.new(options(endpoint, params), request_params_for(endpoint.client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request :gzip
      end
    end

    private

    def options(endpoint, params)
      req_params = __base_options(endpoint)
      client = endpoint.client

      add_token_header(req_params, client) if client_responds_to_token?(client)

      # Set Content-Type if required (skip for GET requests)
      add_content_type_header(req_params, params, endpoint)

      req_params[:headers][:accept_encoding] = 'gzip,deflate,br'

      req_params
    end

    # Adds the token header to the request parameters if token is present
    def add_token_header(req_params, client)
      req_params[:headers][client.token_header] = client.token
    end

    # Checks if the client can respond to token and token header methods
    def client_responds_to_token?(client)
      client.respond_to?(:token) && client.respond_to?(:token_header)
    end

    # Conditionally adds the Content-Type header
    def add_content_type_header(req_params, params, endpoint)
      return unless !params[:get_request] && endpoint.req_params

      req_params[:headers]['Content-Type'] = 'application/json'
    end

    def __base_options(endpoint)
      {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}"
        },
        url: endpoint.base_url
      }
    end

    # Allows to customize request params per-client
    def request_params_for(client)
      {
        request: {
          timeout: client.timeout,
          open_timeout: client.open_timeout
        }
      }
    end
  end
end
