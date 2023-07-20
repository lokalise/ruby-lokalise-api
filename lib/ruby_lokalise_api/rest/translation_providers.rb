# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TranslationProviders
      # Returns translation providers
      #
      # @see https://developers.lokalise.com/reference/list-all-providers
      # @return [RubyLokaliseApi::Collections::TranslationProviders]
      # @param team_id [String, Integer]
      # @param req_params [Hash]
      def translation_providers(team_id, req_params = {})
        name = 'TranslationProviders'
        params = { query: team_id, req: req_params }

        response = endpoint(name: name, params: params).do_get

        # We must patch content because the API does not return team_id and it's mandatory to build resource URLs
        response.patch_content_with 'team_id', team_id

        collection name, response
      end

      # Returns a single translation provider
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-provider
      # @return [RubyLokaliseApi::Resources::TranslationProvider]
      # @param team_id [String, Integer]
      # @param provider_id [String, Integer]
      def translation_provider(team_id, provider_id)
        params = { query: [team_id, provider_id] }

        response = endpoint(name: 'TranslationProviders', params: params).do_get

        # We must patch content because the API does not return team_id and it's mandatory to build resource URLs
        response.patch_content_with 'team_id', team_id

        resource 'TranslationProvider', response
      end
    end
  end
end
