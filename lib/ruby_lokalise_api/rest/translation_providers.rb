# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TranslationProviders
      # Returns all translation providers for the given team
      #
      # @see https://developers.lokalise.com/reference/list-all-providers
      # @return [RubyLokaliseApi::Collection::TranslationProvider<RubyLokaliseApi::Resources::TranslationProvider>]
      # @param team_id [String]
      # @param params [Hash]
      def translation_providers(team_id, params = {})
        c_r RubyLokaliseApi::Collections::TranslationProvider, :all, team_id, params
      end

      # Returns a single translation provider for the given team
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-provider
      # @return [RubyLokaliseApi::Resources::TranslationProvider]
      # @param team_id [String]
      # @param provider_id [String, Integer]
      def translation_provider(team_id, provider_id)
        c_r RubyLokaliseApi::Resources::TranslationProvider, :find, [team_id, provider_id]
      end
    end
  end
end
