# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'
require 'faraday/gzip'
require 'yaml'
require 'addressable/template'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'oauth2' => 'OAuth2',
  'oauth2_client' => 'OAuth2Client',
  'oauth2_endpoint' => 'OAuth2Endpoint',
  'oauth2_token' => 'OAuth2Token',
  'oauth2_refreshed_token' => 'OAuth2RefreshedToken'
)
loader.setup

# Official Ruby client for Lokalise APIv2
module RubyLokaliseApi
  class << self
    # Initializes a new Client object
    #
    # @return [RubyLokaliseApi::Client]
    # @param token [String]
    # @param params [Hash]
    def client(token, params = {})
      @client = RubyLokaliseApi::Client.new token, params
    end

    # Reset the currently set client
    def reset_client!
      @client = nil
    end

    # Initializes a new OAuth2Client object
    #
    # @return [RubyLokaliseApi::OAuth2Client]
    # @param token [String]
    # @param params [Hash]
    def oauth2_client(token, params = {})
      @oauth2_client = RubyLokaliseApi::OAuth2Client.new token, params
    end

    # Reset the currently set OAuth2 client
    def reset_oauth2_client!
      @oauth2_client = nil
    end

    # Initializes a new Auth client to request OAuth 2 tokens
    #
    # @return [RubyLokaliseApi::OAuth2::Auth]
    # @param client_id [String]
    # @param client_secret [String]
    # @param params [Hash]
    def auth_client(client_id, client_secret, params = {})
      RubyLokaliseApi::OAuth2::Auth.new client_id, client_secret, params
    end
  end
end
