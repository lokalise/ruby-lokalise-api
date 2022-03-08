# frozen_string_literal: true

module RubyLokaliseApi
  class Client
    # Returns all translation providers for the given team
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-providers-get
    # @return [RubyLokaliseApi::Collection::TranslationProvider<RubyLokaliseApi::Resources::TranslationProvider>]
    # @param team_id [String]
    # @param params [Hash]
    def translation_providers(team_id, params = {})
      c_r RubyLokaliseApi::Collections::TranslationProvider, :all, team_id, params
    end

    # Returns a single translation provider for the given team
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-provider-get
    # @return [RubyLokaliseApi::Resources::TranslationProvider]
    # @param team_id [String]
    # @param provider_id [String, Integer]
    def translation_provider(team_id, provider_id)
      c_r RubyLokaliseApi::Resources::TranslationProvider, :find, [team_id, provider_id]
    end
  end
end
