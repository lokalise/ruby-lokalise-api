# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class SystemLanguages < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::SystemLanguagesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::SystemLanguage
      DATA_KEY = 'languages'
    end
  end
end
