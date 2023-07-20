# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Translations < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::TranslationsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Translation
    end
  end
end
