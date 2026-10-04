# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TranslationMemories < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TranslationMemoriesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::TranslationMemory
      DATA_KEY = 'translation_memories'
    end
  end
end
