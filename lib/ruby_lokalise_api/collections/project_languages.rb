# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class ProjectLanguages < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::ProjectLanguagesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::ProjectLanguage
      DATA_KEY = 'languages'
    end
  end
end
