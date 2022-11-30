# frozen_string_literal: true

module RubyLokaliseApi
  class Client < BaseClient
    include RubyLokaliseApi::Rest::Branches
    include RubyLokaliseApi::Rest::Comments
    include RubyLokaliseApi::Rest::Contributors
    include RubyLokaliseApi::Rest::CustomTranslationStatuses
    include RubyLokaliseApi::Rest::Files
    include RubyLokaliseApi::Rest::Jwt
    include RubyLokaliseApi::Rest::Keys
    include RubyLokaliseApi::Rest::Languages
    include RubyLokaliseApi::Rest::Orders
    include RubyLokaliseApi::Rest::PaymentCards
    include RubyLokaliseApi::Rest::Projects
    include RubyLokaliseApi::Rest::QueuedProcesses
    include RubyLokaliseApi::Rest::Screenshots
    include RubyLokaliseApi::Rest::Segments
    include RubyLokaliseApi::Rest::Snapshots
    include RubyLokaliseApi::Rest::Tasks
    include RubyLokaliseApi::Rest::TeamUserBillingDetails
    include RubyLokaliseApi::Rest::TeamUserGroups
    include RubyLokaliseApi::Rest::TeamUsers
    include RubyLokaliseApi::Rest::Teams
    include RubyLokaliseApi::Rest::TranslationProviders
    include RubyLokaliseApi::Rest::Translations
    include RubyLokaliseApi::Rest::Webhooks

    def initialize(token, params = {})
      super(token, params)

      @token_header = 'x-api-token'
    end

    def base_url
      'https://api.lokalise.com/api2/'
    end

    def compression?
      true
    end
  end
end
