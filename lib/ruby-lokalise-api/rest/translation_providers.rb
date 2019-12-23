# frozen_string_literal: true

module Lokalise
  class Client
    # Returns all translation providers for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-providers-get
    # @return [Lokalise::Collection::TranslationProvider<Lokalise::Resources::TranslationProvider>]
    # @param team_id [String]
    # @param params [Hash]
    def translation_providers(team_id, params = {})
      c_r Lokalise::Collections::TranslationProvider, :all, team_id, params
    end

    # Returns a single translation provider for the given team
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-provider-get
    # @return [Lokalise::Resources::TranslationProvider]
    # @param team_id [String]
    # @param provider_id [String, Integer]
    def translation_provider(team_id, provider_id)
      c_r Lokalise::Resources::TranslationProvider, :find, [team_id, provider_id]
    end
  end
end
