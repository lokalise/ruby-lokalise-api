# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'
require 'faraday/gzip'
require 'yaml'
require 'addressable'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'oauth2' => 'OAuth2',
  'oauth2_client' => 'OAuth2Client'
)
loader.setup

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

    def auth_client(client_id, client_secret)
      RubyLokaliseApi::OAuth2::Auth.new client_id, client_secret
    end
  end
end
