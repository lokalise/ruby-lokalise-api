# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module TranslationMemories
      # Returns project translation memories
      #
      # @see https://developers.lokalise.com/reference/list-project-translation-memories
      # @return [RubyLokaliseApi::Collections::TranslationMemories]
      # @param project_id [String]
      # @param req_params [Hash]
      def translation_memories(project_id)
        name = 'TranslationMemories'
        params = { query: project_id }
        puts endpoint(name: name, params: params).inspect
        data = endpoint(name: name, params: params).do_get

        collection name, data
      end
    end
  end
end
