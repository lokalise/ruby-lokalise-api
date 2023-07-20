# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TranslationProviders < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TranslationProvidersEndpoint
      RESOURCE = RubyLokaliseApi::Resources::TranslationProvider
    end
  end
end
