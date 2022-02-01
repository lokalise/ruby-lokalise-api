# frozen_string_literal: true

require 'faraday'
require 'httpx/adapters/faraday'
require 'yaml'
require 'addressable'

require 'ruby-lokalise-api/version'
require 'ruby-lokalise-api/json_handler'
require 'ruby-lokalise-api/connection'
require 'ruby-lokalise-api/base_request'
require 'ruby-lokalise-api/request'
require 'ruby-lokalise-api/error'
require 'ruby-lokalise-api/utils/string_utils'
require 'ruby-lokalise-api/utils/attribute_helpers'
require 'ruby-lokalise-api/utils/endpoint_helpers'

require 'ruby-lokalise-api/oauth2/connection'
require 'ruby-lokalise-api/oauth2/request'

require 'ruby-lokalise-api/resources/base'
require 'ruby-lokalise-api/resources/branch'
require 'ruby-lokalise-api/resources/project'
require 'ruby-lokalise-api/resources/project_language'
require 'ruby-lokalise-api/resources/queued_process'
require 'ruby-lokalise-api/resources/key_comment'
require 'ruby-lokalise-api/resources/contributor'
require 'ruby-lokalise-api/resources/file'
require 'ruby-lokalise-api/resources/translation'
require 'ruby-lokalise-api/resources/team_user'
require 'ruby-lokalise-api/resources/task'
require 'ruby-lokalise-api/resources/snapshot'
require 'ruby-lokalise-api/resources/screenshot'
require 'ruby-lokalise-api/resources/key'
require 'ruby-lokalise-api/resources/project_comment'
require 'ruby-lokalise-api/resources/system_language'
require 'ruby-lokalise-api/resources/team'
require 'ruby-lokalise-api/resources/order'
require 'ruby-lokalise-api/resources/payment_card'
require 'ruby-lokalise-api/resources/translation_provider'
require 'ruby-lokalise-api/resources/team_user_group'
require 'ruby-lokalise-api/resources/custom_translation_status'
require 'ruby-lokalise-api/resources/webhook'
require 'ruby-lokalise-api/resources/segment'
require 'ruby-lokalise-api/resources/team_user_billing_details'

require 'ruby-lokalise-api/collections/base'
require 'ruby-lokalise-api/collections/branch'
require 'ruby-lokalise-api/collections/project'
require 'ruby-lokalise-api/collections/team'
require 'ruby-lokalise-api/collections/system_language'
require 'ruby-lokalise-api/collections/project_language'
require 'ruby-lokalise-api/collections/project_comment'
require 'ruby-lokalise-api/collections/queued_process'
require 'ruby-lokalise-api/collections/key_comment'
require 'ruby-lokalise-api/collections/key'
require 'ruby-lokalise-api/collections/contributor'
require 'ruby-lokalise-api/collections/file'
require 'ruby-lokalise-api/collections/translation'
require 'ruby-lokalise-api/collections/team_user'
require 'ruby-lokalise-api/collections/task'
require 'ruby-lokalise-api/collections/snapshot'
require 'ruby-lokalise-api/collections/screenshot'
require 'ruby-lokalise-api/collections/order'
require 'ruby-lokalise-api/collections/payment_card'
require 'ruby-lokalise-api/collections/translation_provider'
require 'ruby-lokalise-api/collections/team_user_group'
require 'ruby-lokalise-api/collections/custom_translation_status'
require 'ruby-lokalise-api/collections/webhook'
require 'ruby-lokalise-api/collections/segment'

require 'ruby-lokalise-api/client'
require 'ruby-lokalise-api/oauth2_client'

require 'ruby-lokalise-api/oauth2/auth'

module Lokalise
  class << self
    # Initializes a new Client object
    #
    # @return [Lokalise::Client]
    # @param token [String]
    # @param params [Hash]
    def client(token, params = {})
      @client = Lokalise::Client.new token, params
    end

    # Reset the currently set client
    def reset_client!
      @client = nil
    end

    # Initializes a new OAuth2Client object
    #
    # @return [Lokalise::OAuth2Client]
    # @param token [String]
    # @param params [Hash]
    def oauth2_client(token, params = {})
      @oauth2_client = Lokalise::OAuth2Client.new token, params
    end

    # Reset the currently set OAuth2 client
    def reset_oauth2_client!
      @oauth2_client = nil
    end

    def auth_client(client_id, client_secret)
      Lokalise::OAuth2::Auth.new client_id, client_secret
    end
  end
end
